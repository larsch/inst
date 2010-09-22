url = "http://www.launchy.net/downloads/win/Launchy2.5.exe"
install do
  get url do |path|
    system path, "/SILENT"
  end
end
