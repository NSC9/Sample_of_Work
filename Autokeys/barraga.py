#must be 0.07 or 0.08
sleeptime = 0.068

barragex=1025
barragey=550

#magic book  interface
keyboard.send_keys("<f4>")
time.sleep(sleeptime)
#barrageclick
mouse.click_relative(barragex, barragey, 1)
time.sleep(sleeptime)
#clickperson
mouse.click_relative_self(0, 0, 1)


