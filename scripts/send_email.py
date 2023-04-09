import os
import datetime
import smtplib
import subprocess
from dotenv import load_dotenv
from email import encoders
from email.mime.base import MIMEBase
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

load_dotenv()

sender_email = os.getenv("EMAIL_USERNAME")
sender_password = os.getenv("EMAIL_PASSWORD")
recipient_email = os.getenv("EMAIL_USERNAME")

datetime = datetime.datetime.now().strftime('%d-%m-%Y-%H-%M-%S')

subject = f"TKDJ backup - {datetime}"

# Execute the Bash script and capture the machine
output = subprocess.check_output(['./get_stats.sh'])
body = output.decode() # include stats into email body

with open("backup.json", "rb") as attachment:
    # Add the attachment to the message
    part = MIMEBase("application", "octet-stream")
    part.set_payload((attachment).read())
encoders.encode_base64(part)
part.add_header(
    "Content-Disposition",
    f"attachment; filename={os.path.basename(f'backup-{datetime}.json')}"
)

message = MIMEMultipart()
message['Subject'] = subject
message['From'] = sender_email
message['To'] = recipient_email
html_part = MIMEText(body)
message.attach(html_part)
message.attach(part)

server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
server.login(sender_email, sender_password)
server.sendmail(sender_email, recipient_email, message.as_string())
server.quit()
