@name = "ruby"
@version = "1.8.6-p383-rc1"

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
