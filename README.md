# Poor Man's Firebase Backup

Backup your Firebase Realtime database and send the dump to your email.

## Running locally 
```bash
# install requirements
pip3 install -r requirements.txt

# create .env file and populate it
mv .env.example .env

# make your scripts executable
chmod 700 backup.py send_email.py

# backup your firebase realtime database. this will create a backup.json file
./backup.py

# send the backup.json file to your email
./send_email.py
```
