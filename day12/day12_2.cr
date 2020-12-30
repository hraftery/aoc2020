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
# waypoint, relative to ship (x,y)
wx = 10
wy = 1

f.each_line do |l|
  c = l[0]
  d = l[1..].to_i64

  case c
    when 'N' then wx, wy = wx  , wy+d
    when 'E' then wx, wy = wx+d, wy
    when 'S' then wx, wy = wx  , wy-d
    when 'W' then wx, wy = wx-d, wy
    when 'L' then (d//90).times { wx, wy = -wy, wx }
    when 'R' then (d//90).times { wx, wy = wy, -wx }
    when 'F' then x, y = x + d*wx, y + d*wy
  end

  #puts "(#{x},#{y}), (#{wx},#{wy})"
end

puts "(#{x},#{y})"
