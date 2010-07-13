URL = "http://sourceforge.net/projects/launchy/files/Launchy%20for%20Windows/0.5/Launchy2.5.exe/download"
def install
  get URL do |path|
    system path, "/SILENT"
  end
end
