# -*- coding: utf-8 -*-
from pymongo import MongoClient
import datetime
import os

mongo_client = MongoClient(
                os.environ['MONGO_HOST'] + ':' +  os.environ['MONGO_PORT'],
                username=os.environ['APP_MONGO_USER'],
                password=os.environ['APP_MONGO_PASS'],
                authSource=os.environ['APP_MONGO_DB']
            )

db = mongo_client[ os.environ['APP_MONGO_DB'] ]
collection = db[ 'test' ]
print(collection.insert_one( {'foo' : 'bar' }))
