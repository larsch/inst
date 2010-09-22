url = "http://the.earth.li/~sgtatham/putty/latest/x86/putty.zip"
install do
  get url do |path|
    unzip path, ToolBinaryPath
  end
end
