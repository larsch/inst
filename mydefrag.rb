url = "http://www.mydefrag.com/Downloads/Download.php?File=MyDefrag-v4.3.1.exe"
destination = ProgramFiles / "mydefrag"
uninstaller = InstallPath / "Uninstall.exe"
install do
  get url do |path|
    system path, "/VERYSILENT", "/DIR=#{dospath InstallPath}", "/TASKS=\"Associate\""
  end
end
uninstall do
  system uninstaller, "/S"
end
