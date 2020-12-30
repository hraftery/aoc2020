f = open("input/day1_1.txt", 'r')
d = f.readlines()
d = [int(i) for i in d]

for i in range(200):
  for j in range(200):
    if i == j:
      continue
    if (2020-d[i]-d[j]) in d:
      print(f"({i},{j}), ({d[i]},{d[j]}), {d[i] * d[j] * (2020-d[i]-d[j])}.")
      exit()
