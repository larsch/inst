url = 'http://download.microsoft.com/download/f/c/a/fca6767b-9ed9-45a6-b352-839afb2a2679/TweakUiPowertoySetup.exe'
homepage = 'http://www.microsoft.com/windowsxp/downloads/powertoys/xppowertoys.mspx'
install do
  get url do |path|
    system path
  end
end
