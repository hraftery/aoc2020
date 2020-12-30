f = open("input/day1_1.txt", 'r')
d = f.readlines()
d = [int(i) for i in d]

for i in range(200):
  if (2020-d[i]) in d:
    print(f"{i}, {d[i]}, {2020-d[i]}, {d[i] * (2020-d[i])}.")
    exit()
