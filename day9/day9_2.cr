filename = "day9/input.txt"
#filename = "day9/input_example.txt"

input = [] of Int64

d = File.read(filename)

d.each_line do |l|
  input.push(l.to_i64)
end

sumTarget = 507622668
#sumTarget = 127

startIdx = 0
endIdx = 0
loop do
  #puts "[" + startIdx.to_s + "..." + endIdx.to_s + "]"
  sum = input[startIdx...endIdx].sum
  case
  when sum < sumTarget
    endIdx += 1
  when sum > sumTarget
    startIdx += 1
    endIdx = startIdx
  else
    puts input[startIdx...endIdx]
    puts input[startIdx...endIdx].min + input[startIdx...endIdx].max
    break
  end
end
