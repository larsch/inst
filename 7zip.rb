URL = "http://downloads.sourceforge.net/sevenzip/7z915.exe"
def install
  get URL do |path|
    system path
  end
end
