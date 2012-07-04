url = "http://www.mydefrag.com/Downloads/Download.php?File=MyDefrag-v4.3.1.exe"
destination = ProgramFiles / "mydefrag"
uninstaller = destination / "Uninstall.exe"
install do
  get url do |path|
    system path, "/VERYSILENT", "/DIR=#{dospath destination}", "/TASKS=\"Associate\""
  end
end
uninstall do
  system uninstaller, "/S"
end
