url = "http://downloads.sourceforge.net/gimp-win/gimp-2.6.10-i686-setup-1.exe"
install do
  get url do |path|
    system path
  end
end
