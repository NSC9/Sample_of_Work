#must be 0.07 or 0.08
sleeptime = 0.082

xc2r6 = 1100
yc2r6 =590

#invent
keyboard.send_keys("<f1>")
time.sleep(sleeptime)
#clickgmaul
mouse.click_relative(xc2r6, yc2r6, 1)

#spec bar interface
keyboard.send_keys("<f5>")
#spec bar click
mouse.click_relative(xc2r6, yc2r6, 1)
time.sleep(sleeptime)
#specbarclick
mouse.click_relative(xc2r6, yc2r6, 1)
time.sleep(sleeptime)
#specbarclick
mouse.click_relative(xc2r6, yc2r6, 1)
time.sleep(sleeptime)
#clickperson
mouse.click_relative_self(0, 0, 1)
