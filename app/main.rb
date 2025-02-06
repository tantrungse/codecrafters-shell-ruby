cmd_list = {
  exit_cmd: 'exit',
  echo_cmd: 'echo',
  type_cmd: 'type'
}
cmd = ''

while cmd != cmd_list[0]
  $stdout.write("$ ")
  cmd, *args = gets.chomp.split(" ")

  

  case cmd
  when cmd_list[:exit_cmd]
    break
  when cmd_list[:echo_cmd]
    $stdout.write("#{args.join(' ')}\n")
  when cmd_list[:type_cmd]
    if cmd_list.has_value?(args[0])
      $stdout.write("#{args[0]} is a shell builtin\n")
    else
      $stdout.write("#{args[0]}: not found\n")
    end
  else
    $stdout.write("#{cmd}: command not found\n")
  end
end
