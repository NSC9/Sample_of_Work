#must be 0.07 or 0.08
sleeptime = 0.09

barragex=1050
barragey=500
b = 1000
bb =140
#pray bar
mouse.click_relative(b, bb, 1)
time.sleep(sleeptime)

#magic book  interface
keyboard.send_keys("<f4>")
time.sleep(sleeptime)
#barrageclick
mouse.click_relative(barragex, barragey, 1)
time.sleep(sleeptime)

#clickperson
mouse.click_relative_self(0, 0, 1)
keyboard.send_keys("<f1>")




