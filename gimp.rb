URL = "http://downloads.sourceforge.net/gimp-win/gimp-2.6.10-i686-setup-1.exe"
def install
  get URL do |path|
    system path
  end
end
