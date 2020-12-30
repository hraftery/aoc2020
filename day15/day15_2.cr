filename = "day15/input.txt"
#filename = "day15/input_example.txt"

f = File.read(filename)

spokenNumbers = f.split(',').map { |s| s.to_i }
puts spokenNumbers

# Keep an index of the index of spoken numbers to improve search speed
spokenNumberIndex = {} of Int32 => Int32
# Index always needs to be one number behind.
spokenNumbers[0...-1].each_with_index { |n, i| spokenNumberIndex[n] = i }

spokenNumber = spokenNumbers.last
numSpoken = spokenNumbers.size
while numSpoken < 30000000
  lastSpokenIndex = spokenNumberIndex[spokenNumber]?
  newSpokenNumber = lastSpokenIndex ? numSpoken - lastSpokenIndex - 1 : 0
  spokenNumberIndex[spokenNumber] = numSpoken-1 # add to or update index (always one number behind)
  
  spokenNumber = newSpokenNumber
  spokenNumbers << spokenNumber
  numSpoken += 1

  #puts "#{numSpoken}, #{spokenNumber}"
end

puts spokenNumbers.last