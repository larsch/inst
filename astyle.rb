url = "http://sourceforge.net/projects/astyle/files/astyle/astyle%202.01/AStyle_2.01_windows.zip/download"
install do
  get url do |path|
    with_temppath do |tmppath|
      unzip path, tmppath
      cp 'astyle/bin/astyle.exe', ToolBinaryPath
    end
  end
end
