URL = "http://download.sysinternals.com/Files/SysinternalsSuite.zip"
def install
  get URL do |path|
    unzip path, ToolBinaryPath
  end
end
