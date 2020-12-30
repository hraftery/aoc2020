#s = "hello
#world"

s = File.read("day6/file_endings.txt")
s.each_line(chomp: false) do |l|
  puts l.size
  puts l.size == l.chomp.size
end
