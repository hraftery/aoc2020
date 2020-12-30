filename = "day19/input.txt"
#filename = "day19/input_example2.txt"

f = File.read(filename)

rules = Array.new(150, "")

fi = f.each_line
fi.each do |l|
  break if l.blank?
  i, rule = l.split(": ")
  rules[i.to_i] = rule
end

regex = construct_regex(rules, 0)
puts regex
regex = Regex.new("^" + regex + "$")

numMatches = 0
fi.each do |l|
  #print(l)
  #puts l =~ regex ? " matches" : " does not match"
  numMatches += 1 if l =~ regex
end
puts numMatches


def construct_regex(rules, index)
  if index == 8
    return "(" + construct_regex(rules, 42) + ")+"
  elsif index == 11
    l = construct_regex(rules, 42)
    r = construct_regex(rules, 31)
    return "(#{l}#{r}|#{l}#{l}#{r}#{r}|#{l}#{l}#{l}#{r}#{r}#{r}|#{l}#{l}#{l}#{l}#{r}#{r}#{r}#{r})"
  else
    rule = rules[index]
    if rule[0] == '"'
      return rule[1]
    elsif rule.index('|')
      leftOr, rightOr = rule.split(" | ")
      leftOrRuleIndices = leftOr.split(' ').map { |s| s.to_i }
      rightOrRuleIndices=rightOr.split(' ').map { |s| s.to_i }
      return "(" + leftOrRuleIndices.reduce("") { |acc, i| acc + construct_regex(rules, i) } + "|" +
                  rightOrRuleIndices.reduce("") { |acc, i| acc + construct_regex(rules, i) } + ")"
    else
      ruleIndices = rule.split(' ').map { |s| s.to_i }
      return ruleIndices.reduce("") { |acc, i| acc + construct_regex(rules, i) }
    end
  end
end
