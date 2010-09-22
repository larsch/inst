url = "ftp://ftp.info-zip.org/pub/infozip/win32/unz552xn.exe"
destination = ToolBinaryPath
install do
  get url do |path|
    with_temppath do
      system path
      mkdir_p destination
      Dir["*.exe"].each do |exe|
        cp exe, destination
      end
    end
  end
end
