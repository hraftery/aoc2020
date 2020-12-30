filename = "day13/input.txt"
#filename = "day13/input_example.txt"

f = File.read(filename)

i = f.each_line
line1 = i.next
line2 = i.next
if line1.is_a? Iterator::Stop || line2.is_a? Iterator::Stop
  exit
end

#departTime = line1.to_i64 { 0 }
busIds = [] of {Int64,Int32} # {id, index}
line2.split(',').each_with_index do |id, i|
  begin
    idNum = id.to_i64
  rescue
  else
    busIds.push({idNum, i})
  end
end

puts typeof(busIds)
puts busIds

a = busIds[0][0]
aOff = busIds[0][1]
busIds.skip(1).each do |id|
  b, bOff = id
  puts "#{a}, #{aOff}, #{b}, #{bOff}"
  puts ret = lcm_with_offsets(a, aOff, b, bOff)
  a, aOff = a*b, a*b - (a*ret[0]-aOff)
end

puts "#{a}, #{aOff} = #{a-aOff}"

def lcm_with_offsets(a, aOff, b, bOff)
  #      a*m - aOff == b*n - bOff
  # ==>  a*m - b*n  == aOff - bOff
  # ==>  a*m % b    == (aOff - bOff) % b
  rhs = (aOff - bOff) % b
  # find a*m
  am = a.step(to:a*b, by:a).find(if_none=0) { |n| n % b == rhs }
  # then b*n = a*m - (aOff - bOff)
  bn = am - (aOff - bOff)
  return { am // a, bn // b } # {m, n}
end
