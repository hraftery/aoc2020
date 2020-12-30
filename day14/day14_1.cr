filename = "day14/input.txt"
#filename = "day14/input_example.txt"

f = File.read(filename)


maskAnd = 2_u64**37 - 1
maskOr  = 0_u64
mem = Hash(UInt64, UInt64).new
f.each_line do |l|
  if l.starts_with?("mask")
    maskStr = l.split(' ')[2]
    maskAnd = maskStr.each_char.reduce(0_u64) { |acc, c| (acc<<1) + (c=='0' ? 0 : 1) }
    maskOr  = maskStr.each_char.reduce(0_u64) { |acc, c| (acc<<1) + (c=='1' ? 1 : 0) }
  else
    addr = l[4..].to_u64(strict: false)
    val = l.split(' ')[2].to_u64
    val &= maskAnd
    val |= maskOr
    #puts "#{addr} => #{val}"
    mem[addr] = val
  end
end

puts mem
puts mem.values.sum(0_u64)
