import serial
import time

ser = serial.Serial("COM7", 9800, timeout=1)

count =0
def get():
    global count
    strm = []
    c =5
    while c>0:
        strm.append(str(ser.readline()))
        # quantity = ser.readline()
        # quantity_de = quantity.decode('utf-8')
        # print(quantity_
        time.sleep(2)
        c-=1
    finale = ""
    count+=1
    for i in strm:
        if (i != "b''"):
            finale = i
    if(finale != "" or count ==2):
        return finale
    else:
        get()
    print(finale)



