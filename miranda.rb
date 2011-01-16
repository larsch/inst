# download_page = 'http://www.miranda-im.org/download/'
update_page = 'http://update.miranda-im.org/update.xml'
install do
  download_url = nil
  scrape_xml update_page do |doc|
    download_url = doc.xpath('/miranda/releases/releasestable/downloadunicodeexe').text
  end
  if download_url
    get download_url do |path|
      system path
    end
  end
end
