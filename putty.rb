URL = "http://the.earth.li/~sgtatham/putty/latest/x86/putty.zip"
def install
  get URL do |path|
    mkdir_p ToolBinaryPath
    chdir ToolBinaryPath do
      system "unzip", path
    end
  end
end
    

