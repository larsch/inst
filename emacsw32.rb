url = 'http://ourcomments.org/Emacs/DL/EmacsW32/EmacsCVS/ptch/Emacs-23-CvsP091103-EmacsW32-1.58.exe'
destination = ProgramFiles / "EmacsW32"
install do
  get url do |path|
    system path, "/SILENT", "/DIR=#{dospath destination}"
  end
end

