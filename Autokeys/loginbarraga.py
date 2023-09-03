#must be 0.07 or 0.08
sleeptime = 0.068

legsx = 1250
legsy =320
topx= 1250
topy = 360
shieldx= 1250
shieldy = 410
barragex=1025
barragey=550
augx= 1200
augy = 590
smitex= 1200
smitey= 530
protx= 1030
proty= 450

#prayer  interface
keyboard.send_keys("<f3>")
time.sleep(sleeptime)
time.sleep(sleeptime)

#prayerclick
mouse.click_relative(augx, augy, 1)
time.sleep(sleeptime)
mouse.click_relative(smitex, smitey, 1)
time.sleep(sleeptime)
mouse.click_relative(protx, proty, 1)
time.sleep(sleeptime)
#invent
keyboard.send_keys("<f1>")
time.sleep(sleeptime)
time.sleep(sleeptime)
#equip items
mouse.click_relative(legsx, legsy, 1)
time.sleep(sleeptime)
mouse.click_relative(topx, topy, 1)
time.sleep(sleeptime)
time.sleep(sleeptime)
time.sleep(sleeptime)
mouse.click_relative(shieldx, shieldy, 1)
time.sleep(sleeptime)
mouse.click_relative(shieldx, shieldy, 1)

#magic book  interface
keyboard.send_keys("<f4>")
time.sleep(sleeptime)
#barrageclick
mouse.click_relative(barragex, barragey, 1)
time.sleep(sleeptime)
#clickperson
mouse.click_relative_self(0, 0, 1)
time.sleep(sleeptime)
time.sleep(sleeptime)
time.sleep(sleeptime)
time.sleep(sleeptime)
time.sleep(sleeptime)
time.sleep(sleeptime)
time.sleep(sleeptime)
time.sleep(sleeptime)
time.sleep(sleeptime)
time.sleep(sleeptime)
#inventory  
keyboard.send_keys("<f1>")
time.sleep(sleeptime)
time.sleep(sleeptime)

#de-equip items
mouse.click_relative(legsx, legsy, 1)
time.sleep(sleeptime)
mouse.click_relative(topx, topy, 1)
time.sleep(sleeptime)
time.sleep(sleeptime)
time.sleep(sleeptime)
mouse.click_relative(shieldx, shieldy, 1)
time.sleep(sleeptime)
mouse.click_relative(shieldx, shieldy, 1)
