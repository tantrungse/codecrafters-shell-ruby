while true
  $stdout.write("$ ")
  command, *args = gets.chomp.split(" ")
  $stdout.write("#{command}: command not found\n")  
end
