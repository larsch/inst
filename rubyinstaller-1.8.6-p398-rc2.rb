@name = "ruby"
@version = "1.8.6-p383-rc1"
URL = "http://rubyforge.org/frs/download.php/69033/rubyinstaller-1.8.6-p398-rc2.exe"
Destination = File.join(Base::ProgramFiles, "rubyinstaller-1.8.6-p398-rc2")
def install
  get URL do |path|
    system path.tr('/','\\'), "/DIR=#{dospath Destination}", "/VERYSILENT"
  end
end

def uninstall
  uninstaller = Dir["#{Destination}/unins*.exe"][0]
  if uninstaller
    system uninstaller, "/VERYSILENT"
  end
end
