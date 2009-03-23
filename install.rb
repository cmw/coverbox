require 'FileUtils'
FileUtils.mkdir_p(File.expand_path('~/.git/'))
sources = ['coverbox.sh', 'git-wtf.rb'].map{|file| File.expand_path(File.join(File.dirname(__FILE__), file))}
FileUtils.cp(sources, File.expand_path('~/.git/'))

File.open(File.expand_path('~/.gitconfig'), 'a') do |file|
  file.puts File.read(File.expand_path(File.join(File.dirname(__FILE__), 'gitconfig')))
end