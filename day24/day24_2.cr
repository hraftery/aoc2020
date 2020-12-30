filename = "day24/input.txt"
#filename = "day24/input_example.txt"

f = File.read(filename)

alias Loc = Tuple(Int32, Int32)
enum Direction
  E
  SE
  SW
  W
  NW
  NE
end

blackTiles = Set(Loc).new


f.each_line do |l|
  firstChar = nil
  dir = nil
  loc : Loc = {0,0}

  l.each_char do |c|
    case firstChar
    when nil
      case c
      when 'e' then dir = Direction::E
      when 'w' then dir = Direction::W
      else firstChar = c
      end
    when 's'
      case c
      when 'e' then dir = Direction::SE
      when 'w' then dir = Direction::SW
      else exit
      end
    when 'n'
      case c
      when 'e' then dir = Direction::NE
      when 'w' then dir = Direction::NW
      else exit
      end
    end

    next unless dir

    loc = loc_in_dir(loc, dir)

    dir = nil
    firstChar = nil
  end

  #puts loc
  # Sigh, another data structure, another set of conventions. Unlike a Hash (even though that's
  # the underlying data structure!), Set.delete doesn't tell you whether it succeed or not.
  # So we use .add? which returns false if it's already present.
  blackTiles.delete(loc) unless blackTiles.add?(loc)
end

puts blackTiles
puts blackTiles.size


100.times do |day|
  newBlackTiles = Set(Loc).new

  # First, do black into white 
  blackTiles.each do |t|
    numAdjBlackTiles = num_adjacent_black_tiles(t, blackTiles)
    
    if numAdjBlackTiles == 1 || numAdjBlackTiles == 2 # then stay black
      newBlackTiles.add(t)
    end
  end

  # Second, do white into black. Harder, because we don't have a list of white tiles to iterate...
  # So start by figuring out the bounds
  minX = maxX = minY = maxY = 0
  blackTiles.each do |t|
    minX = Math.min(minX, t[0])
    maxX = Math.max(maxX, t[0])
    minY = Math.min(minY, t[1])
    maxY = Math.max(maxY, t[1])
  end

  # p! minX
  # p! maxX
  # p! minY
  # p! maxY

  # And now iterate every where
  (minX-2).upto(maxX+2) do |x|
    (minY-2).upto(maxY+2) do |y|
      t : Loc = {x, y}
      
      next if (y.even? && x.odd?) ||
              (y.odd? && x.even?) ||  # not a valid tile location
              blackTiles.includes?(t) # not a white tile

      numAdjBlackTiles = num_adjacent_black_tiles(t, blackTiles)
      
      if numAdjBlackTiles == 2 # then stay black
        newBlackTiles.add(t)
      end
    end
  end

  # update all tiles "simultaneously"
  blackTiles = newBlackTiles
  puts "Day #{day+1}: #{blackTiles.size}"
end


def loc_in_dir(loc, dir)
  x, y = loc
  case dir
  when Direction::E  then x += 2; y += 0
  when Direction::W  then x -= 2; y += 0
  when Direction::SE then x += 1; y -= 1
  when Direction::SW then x -= 1; y -= 1
  when Direction::NE then x += 1; y += 1
  when Direction::NW then x -= 1; y += 1
  end
  return {x, y}
end

def num_adjacent_black_tiles(t, blackTiles)
  return Direction.values.reduce(0) do |acc, dir|
    adjLoc = loc_in_dir(t, dir)
    acc + (blackTiles.includes?(adjLoc) ? 1 : 0)
  end
end
