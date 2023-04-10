const admin = require("firebase-admin");
const fs = require("fs");

const serviceAccount = require("../service_account.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://tennis-app-7dabe.firebaseio.com"
});

const database = admin.database();

const backupRef = database.ref();

backupRef.once("value", (snapshot) => {
  const backupData = JSON.stringify(snapshot.val(), null, 2);
  fs.writeFileSync("./backup.json", backupData);
  console.log("Backup created successfully.");
  process.exit(0)
});

