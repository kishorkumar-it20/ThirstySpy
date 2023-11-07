from datetime0987 import time

from pymongo import MongoClient

try:
    conn = MongoClient()
    print("Connected successfully!!!")
except:
    print("Could not connect to MongoDB")

# database
db = conn.Aquracare

# Created or Switched to collection names: my_gfg_collection
collection = db.People

entry1 = {"name": "John", "time": "10pm", "Quantity" :"678ml"}

collection.insert_one(entry1)
