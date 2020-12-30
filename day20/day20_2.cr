require "./day20_2_lib"

filename = "day20/input.txt"
#filename = "day20/input_example.txt"


# edge => array of Tile with that edge. Every entry has a corresponding "reverseEdge => tileId" pair.
# oh boy, the "new" bit saves having to check whether the (array) value is initialised or not before appending
# see: https://forum.crystal-lang.org/t/how-to-append-to-an-array-that-is-a-default-value-of-a-hash/2144/9
edgesToTiles = Hash(Edge, Array(Tile)).new { |h, k| h[k] = [] of Tile }


f = File.read(filename)

fi = f.each_line

tiles = parse_tiles(fi)

# Create edgesToTiles hash
tiles.each { |t| t.edges.each { |e| edgesToTiles[e        ] << t } }
tiles.each { |t| t.edges.each { |e| edgesToTiles[e.reverse] << t } }

#puts tilesToEdges
#puts edgesToTiles
#puts ""

# puts tiles[0].id
# puts tiles[0].edges
# puts tiles[0].pixels
# tiles[0].orient(210, Pos::Left)
# puts tiles[0].edges
# puts tiles[0].pixels
# exit



cornerTiles = find_corner_tiles(tiles, edgesToTiles)
exit if cornerTiles.size == 0

cornerTiles.each do |cornerTile|
  # start by orientating the top left tile
  matchingEdgeCount = find_matching_edge_count(cornerTile, edgesToTiles)
  # Find the first edge which is an image edge
  firstImageEdge = matchingEdgeCount.index(1)
  break unless firstImageEdge
  # loop back around to the last edge if no image edge is next
  firstImageEdge = 3 if firstImageEdge == 0 && matchingEdgeCount[1] != 1
  # Figure out what the new left edge will look like once this tile is in the top left
  newLeftEdge = cornerTile.edges[firstImageEdge]
  newLeftEdge = newLeftEdge.reverse if firstImageEdge == 0 || firstImageEdge == 1
  # Now we make it the top left corner by putting that edge on the left
  cornerTile.orient(newLeftEdge, Pos::Left)

  puts num_sea_monsters(cornerTile, tiles, edgesToTiles)

  # Then flip it and do it again (note it will implicitly flip, because left and top are face different ways)
  cornerTile.orient(cornerTile.edges[Pos::Left.value], Pos::Top)

  puts num_sea_monsters(cornerTile, tiles, edgesToTiles)
end


MONSTER_WIDTH=20
MONSTER_HEIGHT=3
#        01234567890123456789
#                          # 
#        #    ##    ##    ###
#         #  #  #  #  #  #   

def num_sea_monsters(topLeftTile, tiles, edgesToTiles)
  imageTiles = create_image_from_tiles(topLeftTile, tiles, edgesToTiles)

  # imageTiles.each do |row|
  #   puts row.reduce("") { |acc, t| acc + t.id.to_s + "    " }
  # end

  imagePixels = create_image_pixels_from_image_tiles(imageTiles)

  # imagePixels.each do |row|
  #   puts row.reduce("") { |acc,b| acc + (b ? '#' : '.') }
  # end

  numSeaMonsters = 0
  imagePixels.each_cons(MONSTER_HEIGHT) do |rows|
    0.upto(rows[0].size - MONSTER_WIDTH) do |i|
      r = rows[0][i..]
      if r[18]
        r = rows[1][i..]
        if r[0] && r[5] && r[6] && r[11] && r[12] && r[17] && r[18] && r[19]
          r = rows[2][i..]
          if r[1] && r[4] && r[7] && r[10] && r[13] && r[16]
            numSeaMonsters += 1
            rows[0][i+18] = 
              rows[1][i+0] = rows[1][i+5] = rows[1][i+6] = rows[1][i+11] = rows[1][i+12] = rows[1][i+17] = rows[1][i+18] = rows[1][i+19] =
              rows[2][i+1] = rows[2][i+4] = rows[2][i+7] = rows[2][i+10] = rows[2][i+13] = rows[2][i+16] =
              false
          end
        end
      end
    end
  end

  if numSeaMonsters > 0
    roughness = imagePixels.flatten.reduce(0) { |acc, b| acc + (b ? 1 : 0) }
    puts "Roughness = #{roughness}."
  end

  return numSeaMonsters
end
