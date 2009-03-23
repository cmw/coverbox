require 'FileUtils'
basedir = File.expand_path('~/.my_git/')
FileUtils.mkdir_p(basedir)
sources = ['coverbox.sh', 'coverbox_functions.sh', 'git-wtf.rb', 'bash_prompt.sh'].map{|file| File.expand_path(File.join(File.dirname(__FILE__), file))}
FileUtils.cp(sources, basedir)

File.open(File.expand_path('~/.gitconfig'), 'a') do |file|
  file.puts File.read(File.expand_path(File.join(File.dirname(__FILE__), 'gitconfig')))
end