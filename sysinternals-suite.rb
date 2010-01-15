URL = "http://download.sysinternals.com/Files/SysinternalsSuite.zip"
Destination = ToolBinaryPath

def install
  get URL do |path|
    mkdir_p ToolBinaryPath
    chdir ToolBinaryPath do
      system "unzip", path
    end
  end
end
    

