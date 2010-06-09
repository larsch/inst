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
