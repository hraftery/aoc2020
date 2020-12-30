filename = "day22/input.txt"
#filename = "day22/input_example.txt"
#filename = "day22/input_example2.txt"

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

# puts p1
# puts p2

class GameState
  def initialize(@numGames : Int32)
  end

  property numGames
end

gs = GameState.new(1)
round=1
game=1

play_game(p1, p2, round, game, gs)

def play_game(p1, p2, round, game, gs)
  puts "=== Game #{game} ==="
  puts ""

  history = [] of Tuple(Array(Int32), Array(Int32)) # {p1, p2}

  until p1.empty? || p2.empty?
    puts "-- Round #{round} (Game #{game}) --"
    puts "Player 1's deck: #{p1.join(", ")}"
    puts "Player 2's deck: #{p2.join(", ")}"

    if history.includes?({p1, p2})
      puts "We've seen this shit before. Player 1 wins by default!"
      p2.clear # force a *game* win for p1
      break
    end

    history << {p1.clone, p2.clone}
    
    p1play = p1.shift
    p2play = p2.shift

    puts "Player 1 plays: #{p1play}"
    puts "Player 2 plays: #{p2play}"

    p1wins = p1play > p2play # unless overridden in the subgame
    
    if p1play <= p1.size && p2play <= p2.size
      subP1 = p1[...p1play].clone
      subP2 = p2[...p2play].clone
      gs.numGames += 1
      puts "Playing a sub-game to determine the winner..."
      puts ""

      p1wins = play_game(subP1, subP2, 1, gs.numGames, gs)

      puts "...anyway, back to game #{game}."
    end
  
    if p1wins
      puts "Player 1 wins round #{round} of game #{game}!"
      p1 << p1play << p2play
    else
      puts "Player 2 wins round #{round} of game #{game}!"
      p2 << p2play << p1play
    end

    puts ""
    round += 1
  end

  p1wins = p2.empty?
  puts "The winner of game #{game} is player #{p1wins ? "1" : "2"}!"
  puts ""
  return p1wins

  # puts ""
  # puts "== Post-game results =="
  # puts "Player 1's deck: #{p1.join(", ")}"
  # puts "Player 2's deck: #{p2.join(", ")}"
end


i = 0 # seems that iterators have limited use...
score = (p1.empty? ? p2 : p1).reverse.reduce(0) { |acc, c| i += 1; acc + i*c }

puts ""
puts score
