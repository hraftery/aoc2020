filename = "day9/input.txt"
#filename = "day9/input_example.txt"

input = Deque.new(0,0_i64)

d = File.read(filename)

d.each_line do |l|
  input.push(l.to_i64)
end

windowSize = 25

window = [] of Int64
windowSize.times { window.push(input.shift) }

loop do
  nextNum = input.shift
  puts "Checking " + window.to_s + " for " + nextNum.to_s + "."
  unless window.each_combination(2, true).find { |c| c.sum == nextNum }
    puts nextNum
    break
  end
  window.shift
  window.push(nextNum)
end
