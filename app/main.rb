COMMANDS = {
  exit: 'exit',
  echo: 'echo',
  type: 'type',
  pwd: 'pwd',
  cd: 'cd'
}.freeze

def find_executable(cmd)
  path_directories = ENV['PATH'].split(':')
  path_directories.find { |dir| File.executable?(File.join(dir, cmd)) }
end

loop do
  $stdout.write("$ ")
  cmd, args_str = gets.chomp.split(" ", 2)
  args = args_str&.scan(/'/)&.any? ? args_str&.scan(/'([^']*)'/).flatten : args_str&.split(" ")

  case cmd
  when COMMANDS[:exit]
    break
  when COMMANDS[:echo]
    if args_str&.scan(/'/)&.any?
      $stdout.write("#{args_str.split("'").join}\n")
    else
      $stdout.write("#{args.join(" ")}\n")
    end
  when COMMANDS[:type]
    if COMMANDS.has_value?(args_str)
      $stdout.write("#{args_str} is a shell builtin\n")
    else
      exec_path = find_executable(args_str)
      if exec_path
        $stdout.write("#{args_str} is #{File.join(exec_path, args_str)}\n")
      else
        $stdout.write("#{args_str}: not found\n")
      end
    end
  when COMMANDS[:pwd]
    $stdout.write("#{Dir.pwd}\n")
  when COMMANDS[:cd]
    begin
      args_str == '~' ? Dir.chdir(Dir.home) : Dir.chdir(args_str)
    rescue Errno::ENOENT
      $stdout.write("#{cmd}: #{args_str}: No such file or directory\n")
    end
    
  else
    find_executable(cmd) ? system(cmd, *args) : $stdout.write("#{cmd}: command not found\n")
  end
end
