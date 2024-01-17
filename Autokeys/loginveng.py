
sleeptime = 0.07

b = 1000
bb =140

#pray bar
mouse.click_relative(b, bb, 1)
time.sleep(sleeptime)
#click person
mouse.click_relative_self(0, 0, 1)
time.sleep(sleeptime)

barragex=1025
barragey=600
#magic book  interface
keyboard.send_keys("<f4>")
time.sleep(sleeptime)
#barrageclick
mouse.click_relative(barragex, barragey, 1)
time.sleep(sleeptime)




