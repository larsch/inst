URL = "http://downloads.sourceforge.net/sevenzip/7z915.exe"
DOWNLOAD_PAGE = "http://www.7-zip.org/"
install do
  scrape DOWNLOAD_PAGE do |html|
    hrefs = html.xpath("//a[@href]")
    uris = hrefs.map { |a| URI.join(DOWNLOAD_PAGE, a[:href]) }
    exes = uris.select { |uri| File.basename(uri.request_uri) =~ /^7z(\d+)\.exe$/ }
    get exes.first do |path|
      system path
    end
  end
end
