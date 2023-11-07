import datetime
from datetime import date
import cv2
import numpy as np
import face_recognition
import os

import arduino as rp
from pymongo import MongoClient
NameList=[]

mongo_url = "mongodb+srv://rvrohith0801:1234567890@cluster0.crqhh2m.mongodb.net/Cluster0?retryWrites=true&w=majority"
cluster = MongoClient(mongo_url)
# try:
#     conn = MongoClient()
#     print("Connected successfully!!!")
# except:
#     print("Could not connect to MongoDB")
db = cluster["Cluster0"]

# Created or Switched to collection names: my_gfg_collection
collection = db["People"]

# from PIL import ImageGrab

path = 'images1'
images = []
classNames = []
myList = os.listdir(path)
print(myList)
for cl in myList:
    curImg = cv2.imread(f'{path}/{cl}')
    images.append(curImg)
    classNames.append(os.path.splitext(cl)[0])
print(classNames)


def findEncodings(images):
    encodeList = []
    for img in images:
        img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        encode = face_recognition.face_encodings(img)[0]
        encodeList.append(encode)
    return encodeList


def markAttendance(name,data = "not messuared"):
    #if(name != NameList[-1]):
    with open('Attendance.csv', 'a+') as f:
        myDataList = f.readlines()
        nameList = []
        '''for line in myDataList:
                entry = line.split(',')
                nameList.append(entry[0])'''

        now1 = datetime.datetime.now()
        dtString = now1.strftime('%H:%M:%S')
        date1 = date.today()
        f.writelines(f'\n{name},{dtString},{date1},{data}')
        entry1 = {"name": name, "time": dtString,"date":str(date1), "Quantity": f"{data} ml"}
        collection.insert_one(entry1)


#### FOR CAPTURING SCREEN RATHER THAN WEBCAM
# def captureScreen(bbox=(300,300,690+300,530+300)):
#     capScr = np.array(ImageGrab.grab(bbox))
#     capScr = cv2.cvtColor(capScr, cv2.COLOR_RGB2BGR)
#     return capScr

encodeListKnown = findEncodings(images)
print('Encoding Complete')

cap = cv2.VideoCapture(0)

while True:
    success, img = cap.read()
    # img = captureScreen()
    imgS = cv2.resize(img, (0, 0), None, 0.25, 0.25)
    imgS = cv2.cvtColor(imgS, cv2.COLOR_BGR2RGB)

    facesCurFrame = face_recognition.face_locations(imgS)
    encodesCurFrame = face_recognition.face_encodings(imgS, facesCurFrame)

    for encodeFace, faceLoc in zip(encodesCurFrame, facesCurFrame):
        matches = face_recognition.compare_faces(encodeListKnown, encodeFace)
        faceDis = face_recognition.face_distance(encodeListKnown, encodeFace)
        # print(faceDis)
        matchIndex = np.argmin(faceDis)

        if matches[matchIndex]:
            name = classNames[matchIndex].upper()
            # print(name)
            y1, x2, y2, x1 = faceLoc
            y1, x2, y2, x1 = y1 * 4, x2 * 4, y2 * 4, x1 * 4
            cv2.rectangle(img, (x1, y1), (x2, y2), (0, 255, 0), 2)
            cv2.rectangle(img, (x1, y2 - 35), (x2, y2), (0, 255, 0), cv2.FILLED)
            cv2.putText(img, name, (x1 + 6, y2 - 6), cv2.FONT_HERSHEY_COMPLEX, 1, (255, 255, 255), 2)
            data = rp.get()
            # print(data)

            if(data == "" or data == None):
                continue
            if(len(NameList)>100):
                NameList = []
            NameList.append(name)
            # print(name)
            markAttendance(name,data)


    cv2.imshow('Webcam', img)
    cv2.waitKey(1)

