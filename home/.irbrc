require 'rubygems' # only needed in 1.8
begin 
  require 'irbtools' 
rescue LoadError
  puts 'IRBtools not installed -- ohai IRB!'
end
