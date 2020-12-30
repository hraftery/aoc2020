filename = "day15/input.txt"
#filename = "day15/input_example.txt"

f = File.read(filename)

spokenNumbers = f.split(',').map { |s| s.to_i }
puts spokenNumbers

spokenNumber = spokenNumbers.last
numSpoken = spokenNumbers.size
while numSpoken < 2020
  lastSpokenAgo = spokenNumbers.reverse.skip(1).index{ |n| n == spokenNumber }
  spokenNumber = lastSpokenAgo ? lastSpokenAgo+1 : 0
  spokenNumbers << spokenNumber
  numSpoken += 1

  puts "#{numSpoken}, #{spokenNumber}"
end
