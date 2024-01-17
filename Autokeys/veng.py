#must be 0.07 or 0.08
sleeptime = 0.07
barragex=1025
barragey=600

#magic book  interface
keyboard.send_keys("<f4>")
time.sleep(sleeptime)
time.sleep(sleeptime)
#barrageclick
mouse.click_relative(barragex, barragey, 1)
time.sleep(sleeptime)
keyboard.send_keys("<f1>")



