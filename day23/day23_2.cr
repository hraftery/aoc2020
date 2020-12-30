#input = "389125467" #example
input = "137826495"

cups = [] of Int32

input.each_char { |c| cups << c.to_i }

maxCup = cups.max

until maxCup == 1_000_000
  maxCup += 1
  cups << maxCup
end

#puts cups
puts cups.size


10_000_000.times do #|i|
#100.times do |i|
  currentCup = cups[0]
  cups.rotate! # put the currentCup at the end of the array
  # Now the cups immediately to the right of the currentCup are at the front of the array
  selectedCups = cups.shift(3) # pick up 3 "immediately clockwise of the current cup"

  destinationCup = currentCup-1
  until destinationCupIdx = cups.index(destinationCup)
    destinationCup = (destinationCup-1) % 1_000_001
  end

  # Ah Crystal. 10 minutes searching for the right method, then give up and roll your own.
  destinationCupIdx += 1 # place the cups so they are "immediately clockwise of the destination cup"
  cups = cups[...destinationCupIdx] + selectedCups + cups[destinationCupIdx..]
  
  #oneIdx = cups.index(1).not_nil!
  #puts cups[oneIdx...oneIdx+25]
  #puts i
end

puts "Done"
oneIdx = cups.index(1).not_nil!
cups.rotate!(oneIdx+1)
puts cups[0]
puts cups[1]
