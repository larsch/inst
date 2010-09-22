url = "http://download.sysinternals.com/Files/SysinternalsSuite.zip"
install do
  get url do |path|
    unzip path, ToolBinaryPath
  end
end
