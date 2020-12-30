filename = "day17/input.txt"
#filename = "day17/input_example.txt"

f = File.read(filename)

# Starting state is 8 cubes wide and we need to evolve for 6 cycles
# So if we start 10 elements into a 30 element wide grid, it's as good
# as infinite.
GRID_SIZE = 30
INPUT_OFFSET = 10

grid = Array(Array(Array(Bool))).new
GRID_SIZE.times do |x|
  grid << Array(Array(Bool)).new
  GRID_SIZE.times do |y|
    grid[x] << [false] * GRID_SIZE
  end
end

y = z = INPUT_OFFSET
f.each_line do |l|
  x = INPUT_OFFSET
  l.chars.each do |c|
    grid[x][y][z] = (c == '#')
    x += 1
  end
  y += 1
end

#GRID_SIZE.times do |z|
#  puts "z = #{z}"
#  GRID_SIZE.times do |y|
#    GRID_SIZE.times do |x|
#      print(grid[x][y][z] ? '#' : '.')
#    end
#    puts ""
#  end
#  puts ""
#end

6.times do
  newGrid = grid.clone
  # avoid the edge cases
  (1...GRID_SIZE-1).each do |x|
    (1...GRID_SIZE-1).each do |y|
      (1...GRID_SIZE-1).each do |z|
        numActive = count_active_neighbours(grid, x, y, z)
        if grid[x][y][z]
          newGrid[x][y][z] = (numActive == 2 || numActive == 3)
        else
          newGrid[x][y][z] = (numActive == 3)
        end
      end
    end
  end

  grid = newGrid

#  (9..11).each do |z|
#    puts "z = #{z}"
#    (7..13).each do |y|
#      (8..14).each do |x|
#        print(grid[x][y][z] ? '#' : '.')
#      end
#      puts ""
#    end
#    puts ""
#  end

end

puts grid.flatten.count(true)


def count_active_neighbours(grid, x, y, z)
  numActive = 0
  (x-1..x+1).each do |xi|
    (y-1..y+1).each do |yi|
      (z-1..z+1).each do |zi|
        next if xi == x && yi == y && zi == z
        numActive += 1 if grid[xi][yi][zi]
      end
    end
  end
  return numActive
end
