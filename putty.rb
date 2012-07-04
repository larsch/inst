url = "http://the.earth.li/~sgtatham/putty/latest/x86/putty.zip"
install do
  begin
    get url, if_modified_since: registry.last_modified do |path, options|
      unzip path, ToolBinaryPath
      registry.last_modified = options.last_modified
    end
  rescue NotModified
    puts "Putty is current"
  end
end
