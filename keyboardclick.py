import time
import math
a = 0
for i in range(1,17):
    mouse.click_relative_self(0, 0, 1)
    a += 0.02
    amount = float(round((math.exp(-1+a))/10,4))
    time.sleep(amount)
