url = 'http://media-2.cacetech.com/wireshark/win32/wireshark-win32-1.4.0.exe'
destination = ProgramFiles / "wireshark"
install do
  get url do |path|
    system path, "/S", "/D=#{dospath destination}"
  end
end
