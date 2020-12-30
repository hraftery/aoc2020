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

ways = 1_i64
ones = 0
prev = 0
input.each do |i|
  diff = i-prev
  case
  when diff == 1 then ones += 1
  when diff == 2 then puts "oh no"
  when diff == 3
    if ones > 1
      puts "Run of " + ones.to_s + " ones."
      ways *= ways_to_sum_to(ones)
    end
    ones = 0
  end
  prev = i
end
if ones > 1  # always a 3 at the end
  ways *= ways_to_sum_to(ones)
end

puts ways

def ways_to_sum_to(n)
  case
  when n == 1 then return 1
  when n == 2 then return 2
  when n == 3 then return 4
  else return ways_to_sum_to(n-1) + ways_to_sum_to(n-2) + ways_to_sum_to(n-3)
  end
end
