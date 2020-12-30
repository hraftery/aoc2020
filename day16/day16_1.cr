filename = "day16/input.txt"
#filename = "day16/input_example.txt"

f = File.read(filename)
fi = f.each_line

#Each field is always associated with two ranges, so store min/max of each.
fieldRanges = {} of String => Tuple(Int32, Int32, Int32, Int32)

fi.each do |l|
  break if l.blank?

  field, rangesStr = l.split(':')
  range1, range2 = rangesStr.split(" or ")
  ranges = (range1.split('-') + range2.split('-')).map{|s| s.to_i}

  fieldRanges[field] = Tuple(Int32, Int32, Int32, Int32).from(ranges)
end
puts fieldRanges

fi.next # "your ticket:"
myTicket = [] of Int32
fi.each do |l|
  break if l.blank?

  myTicket = l.split(',').map{|s| s.to_i}
end
puts myTicket

fi.next # blank

nearbyTickets = [] of Array(Int32)
fi.each do |l|
  break if l.blank?

  nearbyTickets << l.split(',').map{|s| s.to_i}
end

puts nearbyTickets


errorRate = 0
nearbyTickets.flatten.each do |val|
  errorRate += val if fieldRanges.each_value.all? { |range| ! valid_for_range(range, val) }
end

puts errorRate

def valid_for_range(range, value)
  if    value >= range[0] && value <= range[1]
    return true
  elsif value >= range[2] && value <= range[3]
    return true
  else
    return false
  end
end
