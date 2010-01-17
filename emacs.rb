URL = "ftp://ftp.gnu.org/pub/gnu/emacs/windows/emacs-23.1-bin-i386.zip"
Destination = ProgramFiles
def install
  get URL do |path|
    mkdir_p Destination
    chdir Destination do
      system "unzip", path
    end
  end
end
