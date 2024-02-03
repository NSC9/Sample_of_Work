b = 1000
bb =140
sleeptime = 0.2
cannonx=530 #square directly under cannon
cannony=300
i = 0
while True:
    i+=1
    s1 = 0.29935
    if i % 250==0:
        time.sleep(sleeptime)
        time.sleep(sleeptime)
        mouse.click_relative(cannonx, cannony, 1)
        time.sleep(sleeptime)
        time.sleep(sleeptime)
        time.sleep(sleeptime)
    mouse.click_relative(b, bb, 1)
    time.sleep(s1)
    
    
