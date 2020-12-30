filename = "day5/input.txt"
#filename = "day5/input_example.txt"


d = File.read(filename)

maxSeatId = 0

d.each_line() do |l|
  row = (l[0] == 'F' ? 0 : 1) << 6 |
        (l[1] == 'F' ? 0 : 1) << 5 |
        (l[2] == 'F' ? 0 : 1) << 4 |
        (l[3] == 'F' ? 0 : 1) << 3 |
        (l[4] == 'F' ? 0 : 1) << 2 |
        (l[5] == 'F' ? 0 : 1) << 1 |
        (l[6] == 'F' ? 0 : 1) << 0
  col = (l[7] == 'L' ? 0 : 1) << 2 |
        (l[8] == 'L' ? 0 : 1) << 1 |
        (l[9] == 'L' ? 0 : 1) << 0
  
  # Obviously seatId just row<<3 + col so could be done without calculating
  # row first, but easier to match up with requirements if we're explicit.
  seatId = row*8 + col; 
  
  #puts seatId
  maxSeatId = Math.max(maxSeatId, seatId)
end

puts maxSeatId
