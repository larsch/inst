require 'net/http'
require 'net/ftp'
require 'fileutils'

class ProgressBar
  PAINT_INTERVAL = 0.25
  
  def initialize(max)
    @max = max
    @prg = 0
    @last_paint = Time.now - 60
    paint
    yield(self)
    puts
  end

  def inc(count)
    @prg += count
    paint if (Time.now > @last_paint + PAINT_INTERVAL) or @prg >= @max
  end

  def paint
    w = 77
    pct = (@prg * 100.0 / @max).round
    n = (@prg * w + (w/2-1)) / @max
    printf "\r%3d%%[" +
      "=" * ([n-1,0].max) +
      ">" * ((n > 0 || n < w-1) ? 1 : 0) + 
      "-" * (w-n) +
      "]#{@prg}/#{@max}", pct
    @last_paint = Time.now
  end
end

class Base
  include FileUtils

  ProgramFiles = "C:/appl"
  Temp = ENV['TEMP']
  ToolBinaryPath = File.join(ProgramFiles, "tools", "bin")

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
      print "\rchdir..."
      ftp.chdir(File.dirname(uri.path))
      print "\rsize..."
      content_length = ftp.size(File.basename(uri.path))
      print "\rget..."
      ftp.getbinaryfile(File.basename(uri.path)) do |fragment|
        yield(content_length, fragment)
      end
    end
  end
  
  def get(url)
    temppath = nil
    uri = URI.parse(url)
    case uri.scheme
    when 'ftp'
      filename = File.basename(uri.path)
      temppath = File.join(Temp, filename)
      bytes_downloaded = 0
      File.open(temppath, "wb") do |f|
        ftpget(uri) do |content_length, fragment|
          f.write(fragment)
          bytes_downloaded += fragment.size
          print "\r#{bytes_downloaded}/#{content_length}"
        end
      end

    when 'http'
      httpget(uri) do |response|
        filename = File.basename(uri.path)
        temppath = File.join(Temp, filename)

        ProgressBar.new(response.content_length) do |pb|
          #if not File.exist?(temppath)
          File.open(temppath, "wb") do |f|
            bytes_downloaded = 0
            response.read_body do |fragment|
              f.write(fragment)
              pb.inc(fragment.size)
              bytes_downloaded += fragment.size
            end
          end
          #end
        end
      end
      
    end

    if temppath
      yield(temppath)
    end
  end

  def unzip(zipfile, targetpath)
    mkdir_p targetpath
    puts "Unzipping #{File.basename(zipfile)} to #{targetpath}"
    system 'unzip', '-q', '-o', zipfile, '-d', targetpath
  end
end

cls = Class.new(Base)
cls.class_eval(IO.read(ARGV[1]))
cls.new.send(ARGV[0])
