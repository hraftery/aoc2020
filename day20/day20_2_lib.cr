E=Edge::SIZE-1
PIXEL_SIZE=8
BYTE_BIT_REVERSAL_TABLE=[0x00_u8, 0x80_u8, 0x40_u8, 0xC0_u8, 0x20_u8, 0xA0_u8, 0x60_u8, 0xE0_u8, 0x10_u8, 0x90_u8, 0x50_u8, 0xD0_u8, 0x30_u8, 0xB0_u8, 0x70_u8, 0xF0_u8, 0x08_u8, 0x88_u8, 0x48_u8, 0xC8_u8, 0x28_u8, 0xA8_u8, 0x68_u8, 0xE8_u8, 0x18_u8, 0x98_u8, 0x58_u8, 0xD8_u8, 0x38_u8, 0xB8_u8, 0x78_u8, 0xF8_u8, 0x04_u8, 0x84_u8, 0x44_u8, 0xC4_u8, 0x24_u8, 0xA4_u8, 0x64_u8, 0xE4_u8, 0x14_u8, 0x94_u8, 0x54_u8, 0xD4_u8, 0x34_u8, 0xB4_u8, 0x74_u8, 0xF4_u8, 0x0C_u8, 0x8C_u8, 0x4C_u8, 0xCC_u8, 0x2C_u8, 0xAC_u8, 0x6C_u8, 0xEC_u8, 0x1C_u8, 0x9C_u8, 0x5C_u8, 0xDC_u8, 0x3C_u8, 0xBC_u8, 0x7C_u8, 0xFC_u8, 0x02_u8, 0x82_u8, 0x42_u8, 0xC2_u8, 0x22_u8, 0xA2_u8, 0x62_u8, 0xE2_u8, 0x12_u8, 0x92_u8, 0x52_u8, 0xD2_u8, 0x32_u8, 0xB2_u8, 0x72_u8, 0xF2_u8, 0x0A_u8, 0x8A_u8, 0x4A_u8, 0xCA_u8, 0x2A_u8, 0xAA_u8, 0x6A_u8, 0xEA_u8, 0x1A_u8, 0x9A_u8, 0x5A_u8, 0xDA_u8, 0x3A_u8, 0xBA_u8, 0x7A_u8, 0xFA_u8, 0x06_u8, 0x86_u8, 0x46_u8, 0xC6_u8, 0x26_u8, 0xA6_u8, 0x66_u8, 0xE6_u8, 0x16_u8, 0x96_u8, 0x56_u8, 0xD6_u8, 0x36_u8, 0xB6_u8, 0x76_u8, 0xF6_u8, 0x0E_u8, 0x8E_u8, 0x4E_u8, 0xCE_u8, 0x2E_u8, 0xAE_u8, 0x6E_u8, 0xEE_u8, 0x1E_u8, 0x9E_u8, 0x5E_u8, 0xDE_u8, 0x3E_u8, 0xBE_u8, 0x7E_u8, 0xFE_u8, 0x01_u8, 0x81_u8, 0x41_u8, 0xC1_u8, 0x21_u8, 0xA1_u8, 0x61_u8, 0xE1_u8, 0x11_u8, 0x91_u8, 0x51_u8, 0xD1_u8, 0x31_u8, 0xB1_u8, 0x71_u8, 0xF1_u8, 0x09_u8, 0x89_u8, 0x49_u8, 0xC9_u8, 0x29_u8, 0xA9_u8, 0x69_u8, 0xE9_u8, 0x19_u8, 0x99_u8, 0x59_u8, 0xD9_u8, 0x39_u8, 0xB9_u8, 0x79_u8, 0xF9_u8, 0x05_u8, 0x85_u8, 0x45_u8, 0xC5_u8, 0x25_u8, 0xA5_u8, 0x65_u8, 0xE5_u8, 0x15_u8, 0x95_u8, 0x55_u8, 0xD5_u8, 0x35_u8, 0xB5_u8, 0x75_u8, 0xF5_u8, 0x0D_u8, 0x8D_u8, 0x4D_u8, 0xCD_u8, 0x2D_u8, 0xAD_u8, 0x6D_u8, 0xED_u8, 0x1D_u8, 0x9D_u8, 0x5D_u8, 0xDD_u8, 0x3D_u8, 0xBD_u8, 0x7D_u8, 0xFD_u8, 0x03_u8, 0x83_u8, 0x43_u8, 0xC3_u8, 0x23_u8, 0xA3_u8, 0x63_u8, 0xE3_u8, 0x13_u8, 0x93_u8, 0x53_u8, 0xD3_u8, 0x33_u8, 0xB3_u8, 0x73_u8, 0xF3_u8, 0x0B_u8, 0x8B_u8, 0x4B_u8, 0xCB_u8, 0x2B_u8, 0xAB_u8, 0x6B_u8, 0xEB_u8, 0x1B_u8, 0x9B_u8, 0x5B_u8, 0xDB_u8, 0x3B_u8, 0xBB_u8, 0x7B_u8, 0xFB_u8, 0x07_u8, 0x87_u8, 0x47_u8, 0xC7_u8, 0x27_u8, 0xA7_u8, 0x67_u8, 0xE7_u8, 0x17_u8, 0x97_u8, 0x57_u8, 0xD7_u8, 0x37_u8, 0xB7_u8, 0x77_u8, 0xF7_u8, 0x0F_u8, 0x8F_u8, 0x4F_u8, 0xCF_u8, 0x2F_u8, 0xAF_u8, 0x6F_u8, 0xEF_u8, 0x1F_u8, 0x9F_u8, 0x5F_u8, 0xDF_u8, 0x3F_u8, 0xBF_u8, 0x7F_u8, 0xFF_u8]


alias Edge = UInt16
struct Edge
  SIZE=10

  def reverse
    reversedEdge = Edge.zero
    workingEdge = self
    count = SIZE
    while workingEdge > 0
      reversedEdge <<= 1
      reversedEdge |= workingEdge.bit(0)
      workingEdge >>= 1
      count -= 1
    end
    return reversedEdge << count
  end

  # Can't `def reverse!` because UInt16 derives from Value which is immutable!
end

# Must be in same order as Tile.edges edges
enum Pos
  Top
  Right
  Bottom
  Left
  POS_MAX
end


class Tile
  NUM_EDGES=4

  def initialize(@id : UInt16)
    @edges  = Array(Edge) .new(NUM_EDGES,  0) # [topEdge, rightEdge, bottomEdge, leftEdge]
    @pixels = Array(UInt8).new(PIXEL_SIZE, 0) # [row1pixels, row2pixels ... row8pixels]
  end
  
  property id : UInt16
  
  property edges
  property pixels

  def orient(edge, pos)
    edgeIndex = @edges.index(edge) || @edges.index(edge.reverse)
    exit unless edgeIndex
  
    anticlockwiseRotationRequired = (edgeIndex - pos.value) % Pos::POS_MAX.value
    @edges.rotate!(anticlockwiseRotationRequired)
    # Now fix up the edges, because a rotation changes which way they point
    if anticlockwiseRotationRequired == 1 || anticlockwiseRotationRequired == 2
      @edges[Pos::Left.value]   = @edges[Pos::Left.value].reverse
      @edges[Pos::Right.value]  = @edges[Pos::Right.value].reverse
    end
    if anticlockwiseRotationRequired == 3 || anticlockwiseRotationRequired == 2
      @edges[Pos::Top.value]    = @edges[Pos::Top.value].reverse
      @edges[Pos::Bottom.value] = @edges[Pos::Bottom.value].reverse
    end

    # Now rotate the pixels
    anticlockwiseRotationRequired.times do
      workingPixels = Array(UInt8).new(PIXEL_SIZE,0)
      PIXEL_SIZE.times do |i|
        workingPixels[i] = @pixels.reduce(0_u8) { |acc, p| (acc<<1) | p.bit(i) }
      end
      @pixels = workingPixels
    end
  
    if @edges[pos.value] != edge # then it must need a flip
      case pos
      when Pos::Top, Pos::Bottom # flipping on vertical axis: top and bottom are reversed, left and right swap places
        @edges[Pos::Top.value]    = @edges[Pos::Top.value].reverse
        @edges[Pos::Bottom.value] = @edges[Pos::Bottom.value].reverse
        @edges.swap(Pos::Left.value, Pos::Right.value)
        # Now the pixels
        @pixels.map! { |p| BYTE_BIT_REVERSAL_TABLE[p] }
      when Pos::Left, Pos::Right  # flipping on horizontal axis: left and right are reversed, top and bottom swap places
        @edges[Pos::Left.value]   = @edges[Pos::Left.value].reverse
        @edges[Pos::Right.value]  = @edges[Pos::Right.value].reverse
        @edges.swap(Pos::Top.value, Pos::Bottom.value)
        # Now the pixels
        @pixels.reverse!
      end
    end
  end
  
end

###################
### parse_tiles ###
###################
def parse_tiles(fi)
  tiles = [] of Tile

  until (tileTitle = fi.next).is_a? Iterator::Stop
    #puts tileTitle
    t = Tile.new(tileTitle[5..8].to_u16)
    fi.each_with_index do |l, i|
      break if l.blank?
      if i==0
        t.edges[Pos::Top.value]    = l.each_char.reduce(0_u16) { |acc, c| (acc<<1) + (c=='.' ? 0 : 1) }
      elsif i==E
        t.edges[Pos::Bottom.value] = l.each_char.reduce(0_u16) { |acc, c| (acc<<1) + (c=='.' ? 0 : 1) }
      else
        t.pixels[i-1] = l[1..8].each_char.reduce(0_u8) { |acc, c| (acc<<1) + (c=='.' ? 0 : 1) }
      end

      t.edges[Pos::Left.value]  |= (1 << E - i) if l[0] == '#'
      t.edges[Pos::Right.value] |= (1 << E - i) if l[E] == '#'
    end
    
    tiles << t
  end
  return tiles
end

#########################
### find_corner_tiles ###
#########################
def find_corner_tiles(tiles, edgesToTiles)
  cornerTiles = [] of Tile

  tiles.each do |t|
    matchingEdgeCount = find_matching_edge_count(t, edgesToTiles)
    puts "#{t.id}: #{matchingEdgeCount}"
    if matchingEdgeCount.count(1) == 2
      if matchingEdgeCount[0] == 1 && matchingEdgeCount[3] == 1
        #topLeftTile = t
        puts "**************"
      else
        puts "^^^^"
      end
      cornerTiles << t
    end
  end

  return cornerTiles
end

################################
### find_matching_edge_count ###
################################
def find_matching_edge_count(tile, edgesToTiles)
  return tile.edges.map { |e| edgesToTiles[e].size }
end

###############################
### create_image_from_tiles ###
###############################
def create_image_from_tiles(topLeftTile, tiles, edgesToTiles)
  # 2D array of Tile, with dimensions [width][height], arranged in order to produce the image,
  # with increasing width going to the right and increasing height going down.
  # Dimensions to be allocated once we parse all the tiles and know how big the image is.
  imageTiles = Array(Array(Tile)).new

  numTiles = tiles.size
  imageSizeInTiles = Math.sqrt(numTiles).round(0).to_u8

  # Okay, now go ahead and make the image.
  leftMostTile = topLeftTile
  imageSizeInTiles.times do
    imageRow = [leftMostTile]
    
    thisTile = leftMostTile
    (imageSizeInTiles-1).times do
      rightEdge = thisTile.edges[Pos::Right.value]
      nextTile = edgesToTiles[rightEdge].find { |t| t != thisTile }
      break unless nextTile
      nextTile.orient(rightEdge, Pos::Left)
      imageRow << nextTile

      thisTile = nextTile
    end

    imageTiles << imageRow

    bottomEdge = leftMostTile.edges[Pos::Bottom.value]
    leftMostTile = edgesToTiles[bottomEdge].find { |t| t != leftMostTile }
    break unless leftMostTile
    leftMostTile.orient(bottomEdge, Pos::Top)
  end

  return imageTiles
end


############################################
### create_image_pixels_from_image_tiles ###
############################################
def create_image_pixels_from_image_tiles(imageTiles)
  imagePixels = Array(Array(Bool)).new

  imageTiles.each_with_index do |col,x|
    PIXEL_SIZE.times do |i|
      pixelRow = [] of Bool
      col.each_with_index do |t,y|
        PIXEL_SIZE.times do |j|
          bitSelect = 1 << (PIXEL_SIZE-j-1)
          pixelRow << ((t.pixels[i] & bitSelect) == bitSelect)
        end
      end
      imagePixels << pixelRow
    end
  end

  return imagePixels
end
