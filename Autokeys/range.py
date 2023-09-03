#must be 0.07 or 0.08
sleeptime = 0.073

weaponx = 1050
weapony =330
eaglex= 1125
eagley = 590
augx= 1200
augy = 590

#prayer  interface
keyboard.send_keys("<f3>")
time.sleep(sleeptime)
time.sleep(sleeptime)
#eagleprayerclick
mouse.click_relative(eaglex,eagley,1)
time.sleep(sleeptime)
time.sleep(sleeptime)
time.sleep(sleeptime)


#invent
keyboard.send_keys("<f1>")
time.sleep(sleeptime)
#equip items
mouse.click_relative(weaponx, weapony, 1)
mouse.click_relative(weaponx, weapony, 1)
mouse.click_relative(weaponx, weapony, 1)
time.sleep(sleeptime)
time.sleep(sleeptime)
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

#prayer  interface
keyboard.send_keys("<f3>")
time.sleep(sleeptime)

#augprayerclick
mouse.click_relative(augx, augy, 1)
time.sleep(sleeptime)

#inventory  
keyboard.send_keys("<f1>")
time.sleep(sleeptime)
#de-equip items
mouse.click_relative(weaponx, weapony, 1)
mouse.click_relative(weaponx, weapony, 1)
mouse.click_relative(weaponx, weapony, 1)

