require "bit_array"

filename = "day6/input.txt"
#filename = "day6/input_example.txt"


d = File.read(filename)

NUM_QUESTIONS = 26
yeses = BitArray.new(NUM_QUESTIONS, true) # start with all yeses
totalYeses = 0

d.each_line do |l|
  if ! l.blank?
    personYeses = BitArray.new(NUM_QUESTIONS, false) # start with all noes
    l.each_char { |c| personYeses[c-'a'] = true }
    #puts personYeses
    personYeses.each_with_index do |yes,idx|
      yeses[idx] &= yes # reduce the total yeses to just the person yeses
    end
    #puts yeses
  else
    totalYeses += yeses.count(true)
    puts totalYeses
    yeses = BitArray.new(NUM_QUESTIONS, true) # start with all yeses
  end
end

puts totalYeses + yeses.count(true)