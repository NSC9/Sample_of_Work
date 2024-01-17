#must be 0.07 or 0.08
sleeptime = 0.55
barragex=1025
barragey=480
cannonx=530 #square directly under cannon
cannony=300
ballsx=1025
ballsy=520
while True:
    #keyboard.send_keys("<f1>")
    #time.sleep(sleeptime)
    #mouse.click_relative(ballsx, ballsy, 1)
    #time.sleep(sleeptime)
    keyboard.send_keys("<f4>")
    time.sleep(sleeptime)
    mouse.click_relative(barragex, barragey, 1)
    time.sleep(sleeptime)
    mouse.click_relative(barragex, barragey, 1)
    time.sleep(sleeptime)
    mouse.click_relative(cannonx, cannony, 1)
    time.sleep(sleeptime)
    time.sleep(sleeptime)
    time.sleep(sleeptime)
