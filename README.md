# Poor Man's Firebase Backup

Backup your Firebase Realtime database and send the dump to your email.

## Running locally 

To authenticate a service account and authorize it to access Firebase services, you must generate a private key file in JSON format.

Make sure you have Node 18 installed.

To generate a private key file for your service account:
1. In the Firebase console, open Settings > Service Accounts.
2. Click Generate New Private Key, then confirm by clicking Generate Key.
3. Securely store the JSON file containing the key and rename it to `service_account.json`
4. execute `npm run all`


```bash
# install requirements
npm i

# create .env file and populate it
mv .env.example .env

# backup your firebase realtime database. this will create a backup.json file
npm run backup

# send the backup.json file to your email
npm run email

# or you can do it together like so
npm run all
```

## Using it in a cron job

Here is an example cron job that executes the npm run test command every day at 23:59.

```
# open the crontab editor
crontab -e

# add the following line to the end of the file, with the real path
59 23 * * * /usr/bin/npm run all --prefix /path/to/your/project
```