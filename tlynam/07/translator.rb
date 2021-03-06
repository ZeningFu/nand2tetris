require './parser'

filename = ARGV[0]
output = filename.gsub("vm","asm")

parse = Parser.new

vm = File.read(filename)
counter = 0
vm.each_line do |line|
  line.strip!
  command_type = parse.commandtype(line)
  puts command_type
  case command_type
  when "C_ARITHMETIC"
    counter += 1
    arthmetic = parse.arg1(line)
    parse.writearithmetic(arthmetic,output,counter)
  when "C_PUSH"
    arg2 = parse.arg2(line)
    arg1 = parse.arg1(line)
    parse.writepushpop(command_type,output,arg1,arg2)
  when "C_POP"
    arg2 = parse.arg2(line)
    arg1 = parse.arg1(line) 
    parse.writepushpop(command_type,output,arg1,arg2)
  when "C_LABEL"
    arg1 = parse.arg1(line) 
    puts arg1
  when "C_IF"
    arg1 = parse.arg1(line) 
    puts arg1
  else
    raise "Unhandled Command Type #{command_type}" 
  end
end