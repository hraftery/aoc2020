filename = "day20/input.txt"
#filename = "day20/input_example.txt"

EDGE_SIZE=10
E=EDGE_SIZE-1

f = File.read(filename)

# tileId => [topEdge, rightEdge, bottomEdge, leftEdge]
tilesToEdges = {} of UInt16 => Array(UInt16)

# edge => array of tileId with that edge. Every entry has a corresponding "reverseEdge => tileId" pair.
# oh boy, this saves having to check whether the (array) value is initialised or not before assignment
# see: https://forum.crystal-lang.org/t/how-to-append-to-an-array-that-is-a-default-value-of-a-hash/2144/9
edgesToTiles = Hash(UInt16, Array(UInt16)).new { |h, k| h[k] = [] of UInt16 }

fi = f.each_line

until (tileTitle = fi.next).is_a? Iterator::Stop
  #puts tileTitle
  tileId = tileTitle[5..8].to_u16
  tilesToEdges[tileId] = Array.new(4, 0_u16)
  fi.each_with_index do |l, i|
    break if l.blank?
    if i==0
      tilesToEdges[tileId][0] = l.each_char.reduce(0_u16) { |acc, c| (acc<<1) + (c=='.' ? 0 : 1) }
    elsif i==E
      tilesToEdges[tileId][2] = l.each_char.reduce(0_u16) { |acc, c| (acc<<1) + (c=='.' ? 0 : 1) }
    end

    tilesToEdges[tileId][1] |= (1 << E - i) if l[E] == '#'
    tilesToEdges[tileId][3] |= (1 << E - i) if l[0] == '#'
  end
  
  tilesToEdges[tileId].each { |edge| edgesToTiles[             edge ] << tileId }
  tilesToEdges[tileId].each { |edge| edgesToTiles[reverse_edge(edge)] << tileId }
end

puts tilesToEdges
puts edgesToTiles

puts ""

tilesToEdges.each do |tileId, edges|
  matchingEdgeCount = edges.map { |e| edgesToTiles[e].size }
  puts "#{tileId}: #{matchingEdgeCount}"
  puts "^^^^" if matchingEdgeCount.count(1) == 2
end


def reverse_edge(edge)
  reversedEdge = 0_u16
  count = EDGE_SIZE
  while edge > 0
    reversedEdge <<= 1
    reversedEdge |= (edge & 1)
    edge >>= 1
    count -= 1
  end
  return reversedEdge << count
end
