baseurl = "http://www.imagemagick.org/script/binary-releases.php"
download_url = nil
match = /^ImageMagick-.*-Q8-windows-dll.exe$/

scrape baseurl do |html|
  html.xpath("//a").each do |link|
    if href = link['href']
      url = URI.join(baseurl, href)
      if url.scheme == "http" and File.basename(url.path) =~ match
        download_url = url
      end
    end
  end
end

install do
  get download_url do |path|
    system path
  end
end
