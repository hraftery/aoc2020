filename = "day6/input.txt"
#filename = "day6/input_example.txt"


d = File.read(filename)

NUM_QUESTIONS = 26
yeses = Array(Bool).new(NUM_QUESTIONS, false)
totalYeses = 0

d.each_line do |l|
  if ! l.blank?
    l.each_char { |c| yeses[c-'a'] = true }
  else
    totalYeses += yeses.count(true)
    puts totalYeses
    yeses.fill(false)
  end
end

puts totalYeses + yeses.count(true)