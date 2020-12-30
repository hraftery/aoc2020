filename = "day16/input.txt"
#filename = "day16/input_example2.txt"

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


# Create mapping from any field (hash keys) to any ticket index (hash value array cols)
# Start with every combination being possible.
possibleMappings = {} of String => Array(Bool)
fieldRanges.each_key { |field| possibleMappings[field] = [true] * myTicket.size }

nearbyTickets.each do |ticket|
  next if ticket.find { |val| fieldRanges.each_value.all? { |range| ! valid_for_range(range, val) } }

  # it's a valid ticket, so now look harder at ways it could be valid
  ticket.each_with_index do |val, i|
    fieldRanges.each do |field, range|
      possibleMappings[field][i] = false if ! valid_for_range(range, val)
    end
  end

  #puts possibleMappings
end

# Now we have all possible mapping, look for unique possible mappings and eliminate alternatives.
while possibleMappings.any? { |field, mapping| mapping.count(true) > 1 }
  possibleMappings.each do |field, mapping|
    if mapping.count(true) == 1
      uniqueIndex = mapping.index(true)
      exit unless uniqueIndex
      possibleMappings.each do |fieldInner, mappingInner|
        next if field == fieldInner
        mappingInner[uniqueIndex] = false
      end
    end
  end
  puts ""
  possibleMappings.each_value { |val| puts val.map {|b| b ? 1 : 0 } }
  #puts possibleMappings
end

# Now we have a unique mapping, apply to our ticket
score = 1_u64
possibleMappings.each do |field, mapping|
  if field.starts_with?("departure")
    mappingIndex = mapping.index(true)
    exit unless mappingIndex
    score *= myTicket[mappingIndex]
  end
  puts score
end



def valid_for_range(range, value)
  if    value >= range[0] && value <= range[1]
    return true
  elsif value >= range[2] && value <= range[3]
    return true
  else
    return false
  end
end
