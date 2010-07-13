URL = "http://www.mydefrag.com/Downloads/Download.php?File=MyDefrag-v4.3.1.exe"
InstallPath = ProgramFiles / "mydefrag"
Uninstaller = InstallPath / "Uninstall.exe"
def install
  get URL do |path|
    system path, "/VERYSILENT", "/DIR=#{dospath InstallPath}", "/TASKS=\"Associate\""
  end
end
def uninstall
  system Uninstaller, "/S"
end
