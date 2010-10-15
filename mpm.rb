require 'net/http'
require 'net/ftp'
require 'fileutils'
require 'cgi'
require 'nokogiri' rescue nil

class String
  def /(n)
    File.join(self, n)
  end
end

class ProgressBar
  UPDATE_INTERVAL = 0.25
  WIDTH = 68
  
  def initialize(max)
    @max = max
    @prg = 0
    @last_fully = -1
    @last_partially = -1
    @last_time = Time.now
    paint
    yield(self)
    puts
  end

  def inc(count)
    @prg += count
    paint
  end

  def paint
    width = WIDTH - 2
    pct = (@prg * 100.0 / @max).round
    progress = [@prg, @max].min
    finished = progress / @max.to_f * width
    fully = finished.floor
    partially = (finished - fully > 0.001 ? 1 : 0)
    now = Time.now
    if fully != @last_fully or partially != @last_partially or now - @last_time > UPDATE_INTERVAL
      rest = width - partially - fully
      printf "\r%3d%% [" + "=" * fully + ">" * partially + "-" * rest + "]", pct
      @last_fully = fully
      @last_partially = partially
      @last_time = now
    end
  end
end
def ProgressBar(max, &block)
  ProgressBar.new(max, &block)
end

module Tasks
  def actions
    @actions ||= {}
  end
  
  def install(&block)
    self.actions[:install] = block
  end
  def uninstall(&block)
    self.actions[:uninstall] = block
  end
end

class Base
  include FileUtils
  include Tasks
  include Nokogiri if defined?(Nokogiri)

  ProgramFiles = "C:/appl"
  Temp = ENV['TEMP']
  ToolBinaryPath = File.join(ProgramFiles, "tools", "bin")

  def initialize
    @cache_enabled = false
  end

  def dospath(path)
    path.tr('/','\\')
  end

  def randstr
    [rand(2**64)].pack("Q").unpack("h*")
  end

  def with_temppath
    path = File.join(Temp, randstr)
    
    dir = Dir.pwd
    begin
      mkdir(path)
      chdir(path)
      yield(path)
    ensure
      chdir(dir)
      rm_rf(path)
    end
  end

  class Redirection < Exception
    def initialize(url)
      @url = url
    end
    def url
      @url
    end
  end
  
  def httpget(uri)
    begin
      puts uri
      Net::HTTP.start(uri.host, uri.port) do |http|
        http.request_get(uri.request_uri) do |response|
          case response
          when Net::HTTPRedirection
            raise Redirection, response['Location']
          else
            yield(response)
          end
        end
      end
    rescue Redirection => redir
      uri = URI.parse(redir.url)
      retry
    end
  end

  def ftpget(uri, &block)
    Net::FTP.open(uri.host) do |ftp|
      print "\rlogging in..."
      ftp.login
      print "\rchdir...     "
      ftp.chdir(File.dirname(uri.path))
      print "\rsize...      "
      content_length = ftp.size(File.basename(uri.path))
      print "\rget...       "
      ProgressBar content_length do |pb|
        ftp.retrbinary("RETR " + File.basename(uri.path), 8192) do |fragment|
          pb.inc fragment.size
          yield fragment
        end
      end
    end
  end
  
  def get(url, options = {})
    temppath = nil
    uri = URI.parse(url)
    case uri.scheme
    when 'ftp'
      filename = File.basename(uri.path)
      temppath = File.join(Temp, filename)
      bytes_downloaded = 0
      if not File.exist?(temppath) or not @cache_enabled
        File.open temppath, "wb" do |f|
          ftpget uri do |fragment|
            f.write fragment
          end
        end
      end

    when 'http'
      httpget(uri) do |response|
        filename = nil
        if contentdisp = response["Content-Disposition"]
          token = /([^()<>@,;:\\\"\/\[\]?={} ]*)/
          qstring = /"([^\"]|\\")*"/
          if contentdisp =~ /filename=\"?(#{token}|#{qstring})\"?/
              filename = $2 || CGI::unescape($3)
          end
        end
        filename ||= File.basename(uri.path)
        temppath = File.join(Temp, filename)

        ProgressBar response.content_length do |pb|
          if not File.exist?(temppath) or not @cache_enabled
            File.open(temppath, "wb") do |f|
            bytes_downloaded = 0
              response.read_body do |fragment|
                f.write(fragment)
                pb.inc(fragment.size)
                bytes_downloaded += fragment.size
              end
            end
          end
        end
      end
      
    end

    if temppath
      if sha1 = options[sha1]
        require 'digest/sha1'
        raise "Checksum failure" unless Digest::SHA1.file(temppath) == sha1.downcase
      end
      yield(temppath)
    end
  end

  def unzip(zipfile, targetpath)
    mkdir_p targetpath
    targetpath = dospath(targetpath)
    zipfile = dospath(zipfile)
    puts "Unzipping #{File.basename(zipfile)} to #{targetpath}"
    system 'unzip', '-q', '-o', zipfile, '-d', targetpath
  end

  def system(*args)
    puts args.join(" ")
    Kernel.system(*args)
  end

  def scrape(url)
    require 'open-uri'
    require 'nokogiri'
    content = nil
    open(url) do |io|
      content = io.read
    end
    yield(Nokogiri::HTML.parse(content))
  end

  def scrape_xml(url)
    require 'open-uri'
    require 'nokogiri'
    content = nil
    open(url) do |io|
      content = io.read
    end
    yield(Nokogiri::XML.parse(content))
  end
end

if ARGV.empty?
  puts <<END_OF_USAGE
Usage: mpm.rb <command> <package>

  mpm install <package>
  mpm uninstall <package>
END_OF_USAGE
  exit
end

obj = Base.new
obj.instance_eval(IO.read(ARGV[1]), ARGV[1])
obj.actions[ARGV[0].to_sym].call
