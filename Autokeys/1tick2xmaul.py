#must be 0.07 or 0.08
sleeptime = 0.095

agsx=1050
agsy=590
infx=1100
infy=630
scmbx=1050
scmby=630
xc2r6 = 1100
yc2r6 =590

a = 1050
aa =220
b = 1000
bb =140
eaglex= 1075
eagley = 590



#invent
keyboard.send_keys("<f1>")
time.sleep(sleeptime)

#specweap
mouse.click_relative(scmbx, scmby, 1)
time.sleep(sleeptime)

#clickperson
mouse.click_relative_self(0, 0, 1)

#prayer  interface
keyboard.send_keys("<f3>")
time.sleep(sleeptime)

#eagleprayerclick
mouse.click_relative(eaglex,eagley,1)
time.sleep(sleeptime)
#clicks spec orb
mouse.click_relative(a, aa, 1)
time.sleep(sleeptime)
time.sleep(sleeptime)
#clicks spec orb
mouse.click_relative(a, aa, 1)



