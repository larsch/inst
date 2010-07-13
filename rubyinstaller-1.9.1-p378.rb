@name = "ruby"
@version = "1.9.1-p378"
URL = "http://rubyforge.org/frs/download.php/71078/rubyinstaller-1.9.1-p378.exe"
Destination = File.join Base::ProgramFiles, "rubyinstaller-1.9.1-p378"
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
