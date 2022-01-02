#!/usr/bin/env python
# coding: utf-8

# https://realpython.com/arduino-python/
# 'pip install pyfirmata' in command prompt/terminal

# In[1]:

import pyfirmata
import time

board = pyfirmata.Arduino('/dev/ttyACM0')

while True:
    board.digital[13].write(1)
    time.sleep(1)
    board.digital[13].write(0)
    time.sleep(1)


# In[ ]:




