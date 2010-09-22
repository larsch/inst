url = "http://download.piriform.com/ccsetup235.exe"
install do
  get url do |path|
    system path
  end
end
