cmd_list = {
  exit_cmd: 'exit',
  echo_cmd: 'echo'
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
  else
    $stdout.write("#{cmd}: command not found\n")
  end
end
