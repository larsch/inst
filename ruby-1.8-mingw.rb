@name = "ruby"
@version = "1.8.6-p383-rc1"

URL = "http://rubyforge.org/frs/download.php/66871/rubyinstaller-1.8.6-p383-rc1.exe"
Destination = File.join(Base::ProgramFiles, "rubyinstaller-1.8.6-p383-rc1")

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
