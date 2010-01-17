@name = "msys-git"
@version = "1.6.5.1-preview20091022"

URL = "http://msysgit.googlecode.com/files/Git-1.6.5.1-preview20091022.exe"
Destination = File.join(Base::ProgramFiles, "Git-1.6.5.1-preview20091022")

def install
  get URL do |path|
    system path.tr('/','\\'), "/DIR=#{Destination.tr('/','\\')}", "/VERYSILENT"
  end
end

def uninstall
  uninstaller = Dir["#{Destination}/unins*.exe"][0]
  if uninstaller
    system uninstaller, "/VERYSILENT"
  end
end
