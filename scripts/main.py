#!/usr/bin/python3

import subprocess

# Execute the backup script as a subprocess and wait for it to finish
backup_process = subprocess.Popen(['python3', './backup.py'])
backup_process.wait()

# Send the email after the backup file is generated
subprocess.Popen(['python3', './send_email.py'])
