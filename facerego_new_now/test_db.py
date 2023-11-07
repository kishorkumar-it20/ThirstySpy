from pymongo import MongoClient
# from pymongo import ServerApi
from pymongo.server_api import ServerApi

def get_database():
    # Provide the mongodb atlas url to connect python to mongodb using pymongo
    client = MongoClient("mongodb+srv://rvrohith:<password>@aquahealth.fh89cre.mongodb.net/?retryWrites=true&w=majority", server_api=ServerApi('1'))
    db = client.test
    # Create the database for our example (we will use the same database throughout the tutorial
    print(db)


# This is added so that many files can reuse the function get_database()

dbname = get_database()
mydict = {"name": "John", "address": "Highway 37"}

# print(dbname.insert_one(mydict))

