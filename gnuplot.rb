url = 'http://downloads.sourceforge.net/project/gnuplot/gnuplot/4.4.2/gp442win32.zip'
install do
  get url do |path|
    unzip path, ProgramFiles
  end
end

