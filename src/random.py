## random.py - Statapult
## E. Croffoot-Suede, S. Kim
## 7 Apr 2022 - STAT 306 DoE
## Random Orders

import random
import pandas as pd

#random.seed(361)

runs = []
for i in range(32):
  runs.append(i)
  
runs = random.sample(runs, k = 32)

arm = []
ball = []
position = []
height = []
tilt = []
for i in range(16):
  arm.append(-1)
  arm.append(1)
for i in range(8):
  for j in range(2):
    ball.append(-1)
  for j in range(2):
    ball.append(1)
for i in range(4):
  for j in range(4):
    position.append(-1)
  for j in range(4):
    position.append(1)
for i in range(2):
  for j in range(8):
    height.append(-1)
  for j in range(8):
    height.append(1)
for i in range(16):
  tilt.append(-1)
for i in range(16):
  tilt.append(1)

df = pd.DataFrame()

df["arm"] = arm
df["ball"] = ball
df["position"] = position
df["height"] = height
df["tilt"] = tilt
df["distance"] = None

print(df)

df.to_csv("data/levels.csv")
