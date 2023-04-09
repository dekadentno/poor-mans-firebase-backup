# Poor Man's Firebase Backup

Backup your Firebase Realtime database and send the dump to your email.

## Running locally 

To authenticate a service account and authorize it to access Firebase services, you must generate a private key file in JSON format.

Make sure you have python 3.x installed.

To generate a private key file for your service account:
1. In the Firebase console, open Settings > Service Accounts.
2. Click Generate New Private Key, then confirm by clicking Generate Key.
3. Securely store the JSON file containing the key and rename it to `service_account.json`
4. execute `./scripts/main.py`


```bash
# install requirements
pip3 install -r requirements.txt

# create .env file and populate it
mv .env.example .env

# make your scripts executable
chmod 700 backup.py send_email.py get_stats.sh main.py

# backup your firebase realtime database. this will create a backup.json file
./backup.py

# send the backup.json file to your email
./send_email.py

# the main.py script can do both of that for you via subprocesses
./main.py
```
