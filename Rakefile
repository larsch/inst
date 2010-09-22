task :default => :mpm
task :mpm => "mpm.zip"

rbfiles = Dir.glob('*.rb') - ['mpm.rb']

file "mpm.zip" => [ "mpm.exe", rbfiles].flatten do
  system "zip", "mpm.zip", "mpm.exe", *rbfiles
end
file "mpm.exe" => "mpm.rb" do
  system "ocra", "mpm.rb"
end
