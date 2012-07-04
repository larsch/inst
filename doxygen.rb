download_page = "http://www.stack.nl/~dimitri/doxygen/download.html"
install do
  scrape download_page do |html|
    dl = html.xpath("//a/@href").map { |href| URI.join(download_page, href.value) }
    dl.select! { |uri| uri.scheme == "http" and File.basename(uri.request_uri) =~ /^doxygen-.*-setup\.exe$/ }
    get dl.first do |path|
      system path, "/SILENT"
    end
  end
end
