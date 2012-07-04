url = "http://download.sysinternals.com/files/SysinternalsSuite.zip"
install do
  begin
    get(url, if_modified_since: registry.last_modified) do |path, options|
      unzip path, ToolBinaryPath
      registry.last_modified = options.last_modified
    end
  rescue NotModified
    puts "SysinternalsSuite is current"
  end
end
