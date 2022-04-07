## random.py - Statapult
## E. Croffoot-Suede, S. Kim
## 7 Apr 2022 - STAT 306 DoE
## Random Orders

import random
import pandas as pd

random.seed(361)

ordered = []
for i in range(16):
  ordered.append(-1)
  ordered.append(1)
  
print(ordered) # [-1, 1, -1, 1...1]

arm = random.sample(ordered, 32)
ball = random.sample(ordered, 32)
position = random.sample(ordered, 32)
height = random.sample(ordered, 32)
tilt = random.sample(ordered, 32)

df = pd.DataFrame()

df["arm"] = arm
df["ball"] = ball
df["position"] = position
df["height"] = height
df["tilt"] = tilt

print(df)

df.to_csv("data/levels.csv")
