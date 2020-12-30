filename = "day14/input.txt"
#filename = "day14/input_example.txt"
#filename = "day14/input_example2.txt"

f = File.read(filename)


maskAnd = 2_u64**37 - 1
maskOr  = 0_u64
mem = Hash(UInt64, UInt64).new
maskFloatArr = [] of UInt8
f.each_line do |l|
  if l.starts_with?("mask")
    maskStr = l.split(' ')[2]
    maskOr   = maskStr.each_char.reduce(0_u64) { |acc, c| (acc<<1) + (c=='1' ? 1 : 0) }
    maskFloatArr.clear
    maskStr.reverse.each_char_with_index { |c, i| maskFloatArr.push(i.to_u8) if c=='X' }
    puts maskFloatArr
  else
    addr = l[4..].to_u64(strict: false)
    val = l.split(' ')[2].to_u64
    addr |= maskOr
    numFloatPermutations = 2_u64**(maskFloatArr.size)
    numFloatPermutations.times do |floatFlags|
      addrMod = addr
      maskFloatArr.each_with_index do |bit, i|
        if floatFlags & (1 << i) != 0 # 0 is truthy in Crystal!
          addrMod |= (1_u64 << bit)
        else
          addrMod &= ~(1_u64 << bit)
        end
      end
      puts "#{addrMod} => #{val}"
      mem[addrMod] = val
    end
  end
end

#puts mem
puts mem.values.sum(0_u64)
