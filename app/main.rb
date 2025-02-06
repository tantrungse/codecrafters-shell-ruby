COMMANDS = {
  exit: 'exit',
  echo: 'echo',
  type: 'type',
  pwd: 'pwd'
}.freeze

def find_executable(cmd)
  path_directories = ENV['PATH'].split(':')
  path_directories.find { |dir| File.executable?(File.join(dir, cmd)) }
end

loop do
  $stdout.write("$ ")
  cmd, *args = gets.chomp.split(" ")
  target = args.first

  case cmd
  when COMMANDS[:exit]
    break
  when COMMANDS[:echo]
    $stdout.write("#{args.join(' ')}\n")
  when COMMANDS[:type]
    if COMMANDS.has_value?(target)
      $stdout.write("#{target} is a shell builtin\n")
    else
      exec_path = find_executable(target)
      if exec_path
        $stdout.write("#{target} is #{File.join(exec_path, target)}\n")
      else
        $stdout.write("#{target}: not found\n")
      end
    end
  when COMMANDS[:pwd]
    $stdout.write("#{Dir.pwd}\n")
  else
    find_executable(cmd) ? system(cmd, target) : $stdout.write("#{cmd}: command not found\n")
  end
end
