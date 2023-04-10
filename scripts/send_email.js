const nodemailer = require("nodemailer");
const { execSync } = require("child_process");
const fs = require("fs");
require('dotenv').config({
    path: `${__dirname}/../.env`
});

// Gmail account credentials
const user = process.env.EMAIL_USERNAME;
const pass = process.env.EMAIL_PASSWORD;

// Recipient email address
const to = process.env.EMAIL_USERNAME;

// Current date and time
const date = new Date().toLocaleString();

// Output of shell script
const output = execSync("./scripts/get_stats.sh").toString();

// File to attach
const file = "./backup.json";

// Create reusable transporter object using SMTP transport
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: user,
    pass: pass
  }
});

// Read the contents of the file to attach
const attachment = {
  filename: "backup.json",
  content: fs.readFileSync(file)
};

// Email message
const message = {
  from: user,
  to: to,
  subject: `TKDJ: backup for ${date}`,
  text: output,
  attachments: [attachment]
};

// Send the email
transporter.sendMail(message, (err, info) => {
  if (err) {
    console.log(err);
  } else {
    console.log(`Email sent: ${info.response}`);
  }
});
