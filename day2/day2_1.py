f = open("input1.txt", 'r')
#f = open("input1head.txt", 'r')

valid=0
for line in f:
  split1 = line.split('-')
  lowCount = int(split1[0])
  split2 = split1[1].split(" ")
  highCount = int(split2[0])
  ruleChar = split2[1][0]
  pword = split2[2].rstrip()
  
  #print(f"{lowCount}, {highCount}, {ruleChar}, {pword}.")

  countChar = pword.count(ruleChar)
  if countChar >= lowCount and countChar <= highCount:
    #print(f"{lowCount}, {highCount}, {ruleChar}, {pword}, {countChar}") 
    valid += 1

print(valid)
