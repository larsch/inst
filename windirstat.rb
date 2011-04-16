url = "http://sourceforge.net/projects/windirstat/files/windirstat/1.1.2%20installer%20re-release%20%28more%20languages%21%29/windirstat1_1_2_setup.exe"
destination = ProgramFiles / "WinDirStat"
uninstaller = destination / "Uninstall.exe"

install do
  get url do |path|
    system path, "/S", "/D=#{dospath destination}"
  end
end
uninstall do
  system uninstaller, "/S"
end
