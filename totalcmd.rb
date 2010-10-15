download_page = 'http://www.ghisler.com/amazons3.php'
install do
  require 'open-uri'
  download_url = nil
  scrape download_page do |doc|
    
    p doc.xpath('//a/@href')
    download_url = doc.xpath('//a/@href').find { |a| a =~ /tcmd.*\.exe/ }
  end
  if download_url
    get download_url do |path|
      exit
      system path
    end
  end
end
