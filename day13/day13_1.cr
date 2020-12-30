filename = "day13/input.txt"
#filename = "day13/input_example.txt"

f = File.read(filename)

i = f.each_line
line1 = i.next
line2 = i.next
if line1.is_a? Iterator::Stop || line2.is_a? Iterator::Stop
  exit
end

departTime = line1.to_i64 { 0 }
busIds = [] of Int64
line2.split(',') do |field|
  begin
    fieldNum = field.to_i64
  rescue
  else
    busIds.push(fieldNum)
  end
end

puts departTime
#puts typeof(busIds)
#puts busIds

#busIds.each { |id| puts id - departTime % id }
res = busIds.reduce({busIds[0],0}) do |acc, id| # acc is {minWaitTime, associatedBusId}
  waitTime = id - departTime % id
  if acc && waitTime < acc[0] # apparently acc can be Nil even though busIds is_a Array(Int64)
    {waitTime, id}
  else
    acc
  end
end

puts res
