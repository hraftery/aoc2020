#input = [5764801, 17807724] #example
input = [19241437, 17346587]

INITIAL_NUMBER=1_i64
MODULUS_NUMBER=20201227
subjectNumber=7

door = INITIAL_NUMBER
card = INITIAL_NUMBER
doorHistory = [] of Int32
cardHistory = [] of Int32

while card != input[0]
  card = transform(card, subjectNumber)
  #break if doorHistory.includes?(card)
  cardHistory << card.to_i32
end

while door != input[1]
  door = transform(door, subjectNumber)
  #break if cardHistory.includes?(door)
  doorHistory << door.to_i32
end

#p! cardHistory
#p! doorHistory

cardLoopSize = cardHistory.size
doorLoopSize = doorHistory.size

p! cardLoopSize
p! doorLoopSize


card = INITIAL_NUMBER
subjectNumber = input[1]
cardLoopSize.times { card = transform(card, subjectNumber) }

door = INITIAL_NUMBER
subjectNumber = input[0]
doorLoopSize.times { door = transform(door, subjectNumber) }

p! door
p! card



def transform(num, subjectNumber)
  num *= subjectNumber
  num %= MODULUS_NUMBER
end
