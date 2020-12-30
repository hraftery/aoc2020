filename = "day22/input.txt"
#filename = "day22/input_example.txt"

f = File.read(filename)

p1 = [] of Int32
p2 = [] of Int32

parsingP1 = nil
f.each_line do |l|
  next if l.blank?

  if l == "Player 1:"
    parsingP1 = true
  elsif l == "Player 2:"
    parsingP1 = false
  else
    (parsingP1 ? p1 : p2) << l.to_i
  end
end

puts p1
puts p2

round=1
until p1.empty? || p2.empty?
  puts "-- Round #{round} --"
  puts "Player 1's deck: #{p1.join(", ")}"
  puts "Player 2's deck: #{p2.join(", ")}"

  p1play = p1.shift
  p2play = p2.shift

  puts "Player 1 plays: #{p1play}"
  puts "Player 2 plays: #{p2play}"

  if p1play > p2play
    puts "Player 1 wins the round!"
    p1 << p1play << p2play
  else
    puts "Player 2 wins the round!"
    p2 << p2play << p1play
  end

  puts ""
  round += 1
end


puts ""
puts "== Post-game results =="
puts "Player 1's deck: #{p1.join(", ")}"
puts "Player 2's deck: #{p2.join(", ")}"


i = 0 # seems that iterators have limited use...
score = (p1.empty? ? p2 : p1).reverse.reduce(0) { |acc, c| i += 1; acc + i*c }

puts ""
puts score
