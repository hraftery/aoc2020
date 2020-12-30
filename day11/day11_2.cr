filename = "day11/input.txt"
#filename = "day11/input_example.txt"

grid = [] of String

d = File.read(filename)

d.each_line do |l|
  grid.push(l)
end

rows = grid.size
cols = grid[0].size

# Add borders to avoid lots of boundary tests
grid.insert(0, "B" * cols) # top border
grid.push("B" * cols) # bottom border
grid.map! { |row| "B" + row + "B" } # left and right borders

#puts grid

gridNew = [] of Array(Char)
(rows+2).times do
  gridNew.push(Array.new(cols+2, 'B'))
end

#puts gridNew

loop do
  didChange = false

  rows.times do |row|
    r = row + 1 # skip the boundary row
    cols.times do |col|
      c = col + 1 # skip the boundary col
      numOccupied = num_occupied_neighbours(grid, r, c)
      #printf("[%d,%d] = %c, %d\n", {c, r, grid[r][c], numOccupied})
      case grid[r][c]
      when 'L'
        if numOccupied == 0
          gridNew[r][c] = '#'
          didChange = true
        else
          gridNew[r][c] = 'L'
        end
      when '#'
        if numOccupied >= 5
          gridNew[r][c] = 'L'
          didChange = true
        else
          gridNew[r][c] = '#'
        end
      else
        gridNew[r][c] = grid[r][c]
      end
      #puts grid
      #puts gridNew
    end
  end

  
  unless didChange
    puts "boom"
    puts grid.reduce(0) { |acc, r| acc + r.count('#') }
    exit
  else
    #puts "nup"
    (rows+2).times do |row|
      #puts grid[row]
      #puts gridNew[row]
      grid[row] = gridNew[row].reduce("") { |acc, i| acc + i }
    end
    #puts gridNew
    #puts grid
  end
end

enum Direction
  N
  NE
  E
  SE
  S
  SW
  W
  NW
end

def num_occupied_neighbours(grid, row, col)
  num = 0
  Direction.each do |dir|
    r = row
    c = col

    loop do
      case dir
      when .n?  then r, c = r-1, c
      when .ne? then r, c = r-1, c+1
      when .e?  then r, c = r  , c+1
      when .se? then r, c = r+1, c+1
      when .s?  then r, c = r+1, c
      when .sw? then r, c = r+1, c-1
      when .w?  then r, c = r  , c-1
      when .nw? then r, c = r-1, c-1
      end
      
      case grid[r][c]
      when '.' then next # only if it's floor do we keep looking
      when '#' then num += 1
        # 'B' or 'L', then break without action
      end
      
      break
    end
  end

  return num
end

