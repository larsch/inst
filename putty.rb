URL = "http://the.earth.li/~sgtatham/putty/latest/x86/putty.zip"
def install
  get URL do |path|
    unzip path, ToolBinaryPath
  end
end
