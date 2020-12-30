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
    if passport.has_key?("byr") && passport["byr"].to_i >= 1920 && passport["byr"].to_i <= 2002 &&
       passport.has_key?("iyr") && passport["iyr"].to_i >= 2010 && passport["iyr"].to_i <= 2020 &&
       passport.has_key?("eyr") && passport["eyr"].to_i >= 2020 && passport["eyr"].to_i <= 2030 &&
       passport.has_key?("hgt") &&((passport["hgt"].ends_with?("cm") && passport["hgt"].to_i(strict: false) >= 150 &&
                                                                        passport["hgt"].to_i(strict: false) <= 193) ||
                                   (passport["hgt"].ends_with?("in") && passport["hgt"].to_i(strict: false) >=  59 &&
                                                                        passport["hgt"].to_i(strict: false) <=  76)) &&
       passport.has_key?("hcl") && passport["hcl"] =~ /#[0-9a-f]{6}/ &&
       passport.has_key?("ecl") && (passport["ecl"] == "amb" || passport["ecl"] == "blu" || passport["ecl"] == "brn" ||
                                    passport["ecl"] == "gry" || passport["ecl"] == "grn" || passport["ecl"] == "hzl" ||
                                    passport["ecl"] == "oth") &&
       passport.has_key?("pid") && passport["pid"] =~ /[0-9]{9}/
      validCount += 1
      #puts validCount
    else
      puts passport
    end
    passport.clear
  end
end
puts validCount
puts totalCount
