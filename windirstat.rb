url = "http://windirstat.info/wds_current_setup.exe"
destination = ProgramFiles / "WinDirStat"
uninstaller = InstallPath / "Uninstall.exe"
install do
  get url do |path|
    system path, "/S", "/D=#{dospath InstallPath}"
  end
end
uninstall do
  system uninstaller, "/S"
end
