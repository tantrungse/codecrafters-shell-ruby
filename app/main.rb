command_list = ['exit']
command = ''

while command != command_list[0]
  $stdout.write("$ ")
  command, *args = gets.chomp.split(" ")
  $stdout.write("#{command}: command not found\n") unless command == command_list[0]
end
