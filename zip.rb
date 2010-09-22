url = "ftp://ftp.info-zip.org/pub/infozip/win32/zip232xn.zip"
destination = ToolBinaryPath
install do
  get url do |path|
    with_temppath do
      system "unzip", path
      mkdir_p destination
      Dir["*.exe"].each do |exe|
        cp exe, destination
      end
    end
  end
end
