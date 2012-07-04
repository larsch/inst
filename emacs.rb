url = "http://ftp.gnu.org/pub/gnu/emacs/windows/emacs-23.4-bin-i386.zip"
url = "http://ftp.gnu.org/pub/gnu/emacs/windows/emacs-24.1-bin-i386.zip"
destination = ProgramFiles
install do
  get url do |path|
    unzip path, destination
  end
end
