url = "http://www.sliksvn.com/pub/Slik-Subversion-1.6.12-win32.msi"
install do
  get url do |path|
    system "msiexec", "/i", dospath(path)
  end
end
