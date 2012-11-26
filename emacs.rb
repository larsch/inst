require 'natural_sort_kernel'
downloadpage = "http://mirrors.dotsrc.org/gnu/emacs/windows/"
install do
  scrape downloadpage do |html|
    file = html.xpath('//a/@href').map { |a| a.value }.select { |a| a =~ /^emacs-.*-i386.zip$/ }.natural_sort.last
    get URI.join(downloadpage, file) do |path|
      unzip path, ProgramFiles
    end
  end
  exit
end
