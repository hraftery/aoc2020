filename = "day10/input.txt"
#filename = "day10/input_example.txt"
#filename = "day10/input_example2.txt"

input = [] of Int64

d = File.read(filename)

d.each_line do |l|
  input.push(l.to_i64)
end

input.sort!
#puts input

ones = 0
twos = 0
threes = 0
prev = 0
input.each do |i|
  diff = i-prev
  case
  when diff == 1 then ones += 1
  when diff == 2 then twos += 1
  when diff == 3 then threes += 1
  end
  prev = i
end
threes += 1 # always a 3 at the end
puts ones
puts twos
puts threes
