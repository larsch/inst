@name = "ruby"
@version = "1.8.7-p249"
URL = "http://rubyforge.org/frs/download.php/71067/rubyinstaller-1.8.7-p249.exe"
Destination = File.join Base::ProgramFiles, "rubyinstaller-1.8.7-p249.exe"
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
