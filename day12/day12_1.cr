filename = "day12/input.txt"
#filename = "day12/input_example.txt"

enum Direction
  N
  E
  S
  W
  MAX
end

f = File.read(filename)

x = y = 0
dir = Direction::E

f.each_line do |l|
  c = l[0]
  d = l[1..].to_i64

  if c == 'F'
    case dir
      when .n? then c = 'N'
      when .e? then c = 'E'
      when .s? then c = 'S'
      when .w? then c = 'W'
    end
  end

  case c
    when 'N'  then x, y = x-d, y
    when 'E'  then x, y = x  , y+d
    when 'S'  then x, y = x+d, y
    when 'W'  then x, y = x  , y-d
    when 'L'  then dir = Direction.from_value((dir.value - d//90 + Direction::MAX.value) % Direction::MAX.value)
    when 'R'  then dir = Direction.from_value((dir.value + d//90                       ) % Direction::MAX.value)
  end

  #puts "(#{x},#{y})"
end

puts "(#{x},#{y})"
