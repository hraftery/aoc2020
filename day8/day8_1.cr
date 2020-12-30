filename = "day8/input.txt"
#filename = "day8/input_example.txt"

prog = [] of Tuple(String, Int32)

d = File.read(filename)

d.each_line do |l|
  op, arg = l.split(' ')
  prog.push({op, arg.to_i})
end

#puts prog

result = nil
changeIdx = -1

loop do
  # find next nop or jmp
  prog.each_index(start: changeIdx+1, count: prog.size) do |i|
    if prog[i][0] == "nop" || prog[i][0] == "jmp"
      changeIdx = i
      break
    end
  end

  if prog[changeIdx][0] == "nop"
    prog[changeIdx] = { "jmp", prog[changeIdx][1] }
  else
    prog[changeIdx] = { "nop", prog[changeIdx][1] }
  end

  break if result = runProg(prog)

  # change it back
  if prog[changeIdx][0] == "nop"
    prog[changeIdx] = { "jmp", prog[changeIdx][1] }
  else
    prog[changeIdx] = { "nop", prog[changeIdx][1] }
  end
end

puts result


def runProg(prog)
  pc = 0
  acc = 0
  pcHistory = [] of Int32

  until pcHistory.includes?(pc)
    pcHistory.push(pc)
    op, arg = prog[pc]
    #puts pc.to_s + ": " + op + ", " + arg.to_s
    case op
    when "nop"
      pc += 1
    when "acc"
      acc += arg
      pc += 1
    when "jmp"
      pc += arg
    end

    if pc == prog.size
      return acc
    end
  end

  return nil

  #puts acc
end
