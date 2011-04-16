require 'open-uri'

url = "http://rubyforge.org/frs/download.php/74298/rubyinstaller-1.9.2-p180.exe"
name = File.basename(url).gsub(/\.exe$/, '')
version = name[/rubyinstaller-(.*)/, 1]
destination = Base::ProgramFiles / name
download_page = 'http://rubyinstaller.org/downloads/'

install do
  get url do |path|
    # system "\"#{dospath path}\" /TASKS=\"MODPATH,ASSOCFILES\" /DIR=\"#{dospath destination}\""
    system dospath(path), "/TASKS=\"MODPATH,ASSOCFILES\"", "/DIR=\"#{dospath destination}\""
  end
end

uninstall do
  uninstaller = Dir["#{destination}/unins*.exe"][0]
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
