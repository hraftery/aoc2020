filename = "day4/input.txt"
#filename = "day4/input_example.txt"


d = File.read(filename)

totalCount = 0
validCount = 0
passport = {} of String => String

d.each_line(chomp: false) do |l|
  if ! l.blank?
    l.split(' ') do |keyValPair|
      key, val = keyValPair.split(':')
      passport[key] = val.chomp
    end
  end

  if l.blank? || l.size == l.chomp.size # blank line or no new line (ie. EOF)
    #puts passport
    totalCount += 1
    if has_required_keys(passport)
      validCount += 1
      #puts validCount
    else
      puts passport
    end
    passport.clear
  end
end

if has_required_keys(passport)
  validCount += 1
end

puts validCount
puts totalCount

def has_required_keys(p) : Bool
  p.has_key?("byr") &&
  p.has_key?("iyr") &&
  p.has_key?("eyr") &&
  p.has_key?("hgt") &&
  p.has_key?("hcl") &&
  p.has_key?("ecl") &&
  p.has_key?("pid")
end
