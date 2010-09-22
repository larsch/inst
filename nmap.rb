url = "http://nmap.org/dist/nmap-5.21-win32.zip"
install do
  get url do |path|
    unzip path, ProgramFiles
  end
end
