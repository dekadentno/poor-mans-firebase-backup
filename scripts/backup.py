import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
import json
import datetime
import os
from dotenv import load_dotenv

load_dotenv()

# Set up Firebase Admin SDK
cred = credentials.Certificate('../service_account.json') # replace with your own service account key
firebase_admin.initialize_app(cred, {
    'databaseURL': os.getenv("DATABASE_URL") # replace with your own database URL
})

# Backup the entire database to a JSON file
ref = db.reference('/')
data = ref.get()
filename = 'backup.json'
with open(filename, 'w') as outfile: # replace with your desired output filename
    json.dump(data, outfile)
