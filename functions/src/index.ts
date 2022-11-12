import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();
const db = admin.firestore();
// const fcm = admin.messaging();

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

export const everyMinuteJob = functions.pubsub.schedule("every 1 minutes")
    .onRun(async () => {
      console.log("started");
      admin.auth().listUsers().then((userListResult) => {
        userListResult.users.forEach(async (userRecord)=> {
          console.log("user", userRecord.toJSON());

          const messageRef = db.collection("users").doc(userRecord.uid)
              .collection("messages").doc();

          await messageRef.set({
            title: "Hello World",
            body: "Bom dia, Good morning",
            creationDate: Date.now(),
            creationTime: {hours: 22, minutes: 10},
          });
          
        });
      }).catch((error) => {
        console.log("Error listing users:", error);
      });
    });
