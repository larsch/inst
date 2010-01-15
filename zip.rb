URL = "ftp://ftp.info-zip.org/pub/infozip/win32/zip232xn.zip"
Destination = File.join(ProgramFiles, "tools", "bin")
def install
  get URL do |path|
    with_temppath do
      system "unzip", path
      mkdir_p Destination
      Dir["*.exe"].each do |exe|
        cp exe, Destination
      end
    end
  end
end
