URL = "http://windirstat.info/wds_current_setup.exe"
InstallPath = ProgramFiles / "WinDirStat"
Uninstaller = InstallPath / "Uninstall.exe"
def install
  get URL do |path|
    system path, "/S", "/D=#{dospath InstallPath}"
  end
end
def uninstall
  system Uninstaller, "/S"
end
