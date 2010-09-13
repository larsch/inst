require 'open-uri'

URL = "http://rubyforge.org/frs/download.php/72170/rubyinstaller-1.9.2-p0.exe"
@name = File.basename(URL).gsub(/\.exe$/, '')
@version = @name[/rubyinstaller-(.*)/, 1]
Destination = Base::ProgramFiles / @name
download_page = 'http://rubyinstaller.org/downloads/'

install do
  get URL do |path|
    system path.tr('/','\\'), "/DIR=#{dospath Destination}", "/VERYSILENT"
  end
end

uninstall do
  uninstaller = Dir["#{Destination}/unins*.exe"][0]
  if uninstaller
    system uninstaller, "/VERYSILENT"
  end
end

def scrape
  doc = Nokogiri::HTML(open(download_page))
  p doc.xpath('//a').map { |a|
    if href = a['href']
      basename = File.basename(URI.parse(href).path)
      basename =~ /^rubyinstaller-(\d+)\.(\d+)\.(\d+)-p(\d+)\.exe$/ && href
    end
  }.select {|x| x}
end
