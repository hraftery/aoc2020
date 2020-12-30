filename = "day18/input.txt"
#filename = "day18/input_example.txt"

f = File.read(filename)

total = 0_i64
f.each_line do |l|
  #puts l
  l = put_parentheses_around_addition(l)
  #puts l
  subTotal = calc_sub_total(l.each_char)
  puts subTotal
  total += subTotal
end
puts total



def calc_sub_total(ci)
  leftArgChar = ci.next
  exit if leftArgChar.is_a? Iterator::Stop

  leftArg = leftArgChar == '(' ? calc_sub_total(ci) : leftArgChar.to_i64

  loop do
    beforeOperator = ci.next # could be end of statement, end of parentheses, or space
    if beforeOperator.is_a? Iterator::Stop || beforeOperator == ')'
      return leftArg # that's it for the subtotal
    end

    operator = ci.next
    exit if operator.is_a? Iterator::Stop

    ci.next # space

    rightArgChar = ci.next
    exit if rightArgChar.is_a? Iterator::Stop

    rightArg = rightArgChar == '(' ? calc_sub_total(ci) : rightArgChar.to_i

    case operator
    when '+' then leftArg += rightArg
    when '-' then leftArg -= rightArg
    when '*' then leftArg *= rightArg
    when '/' then leftArg /= rightArg
    else
      puts "Invalid operator: #{operator}."
      exit
    end
  end
end


def put_parentheses_around_addition(l)
  i = 0
  while i = l.index('+', i)
    # backwards first
    iBack = i-2
    pCount = 0 # num parentheses seen
    loop do
      c = l[iBack]
      if c == ')'
        pCount += 1
      elsif c == '('
        pCount -= 1
      end
      break if pCount == 0
      iBack -= 1
    end
    
    # now forwards 
    iForward = i+2
    pCount = 0 # num parentheses seen
    loop do
      c = l[iForward]
      if c == '('
        pCount += 1
      elsif c == ')'
        pCount -= 1
      end
      break if pCount == 0
      iForward += 1
    end
    iForward += 1 # insert at next character

    l = l[...iBack] + "(" + l[iBack...iForward] + ")" + l[iForward...]
    #puts l
    i += 2 # start again at character after the '+', accounting for extra '('
  end

  return l
end