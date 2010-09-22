url = "http://msysgit.googlecode.com/files/Git-1.7.2.3-preview20100911.exe"
sha1 = "16862fcab1c5a0f66d4232c4b6371b5c4f0936af"
destination = ProgramFiles / "Git-1.7.2.3-preview20100911"

install do
  get url, :sha1 => sha1 do |path|
    system dospath(path), "/DIR=#{dospath destination}", "/VERYSILENT"
  end
end

uninstall do
  uninstaller = Dir["#{Destination}/unins*.exe"][0]
  system uninstaller, "/VERYSILENT"
end
