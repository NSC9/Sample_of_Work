
sleeptime = 0.07

a = 1050
aa =220
b = 1000
bb =140
#pray bar
mouse.click_relative(b, bb, 1)
time.sleep(sleeptime)

#specobr
mouse.click_relative(a, aa, 1)
time.sleep(sleeptime)
#click person
mouse.click_relative_self(0, 0, 1)
barragex=1025
barragey=600
time.sleep(sleeptime)
#magic book  interface
keyboard.send_keys("<f4>")
time.sleep(sleeptime)
#barrageclick
mouse.click_relative(barragex, barragey, 1)
time.sleep(sleeptime)
#invent  interface
keyboard.send_keys("<f1>")
