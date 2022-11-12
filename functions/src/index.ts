import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
admin.initializeApp();
// const db = admin.firestore();
const fcm = admin.messaging();

// export const everyMinuteJob = functions.pubsub.schedule("every 1 minutes")
//     .onRun(async () => {
//       console.log("started");
//       admin.auth().listUsers().then((userListResult) => {
//         userListResult.users.forEach(async (userRecord)=> {
//           console.log("user", userRecord.toJSON());

//           const messageRef = db.collection("users").doc(userRecord.uid)
//               .collection("messages").doc();

//           await messageRef.set({
//             title: "Hello World",
//             body: "Bom dia, Good morning",
//             creationDate: Date.now(),
//             creationTime: {hours: 22, minutes: 10},
//             id: messageRef.id
//           });
//         });
//       }).catch((error) => {
//         console.log("Error listing users:", error);
//       });
//     });

exports.every1minuteNot = functions.pubsub.schedule("every 1 minutes")
    .onRun(async () => {
      console.log("started");
      //   const configurationSnapshot = db.collection("configuration").get();
      //   (await configurationSnapshot).docs.forEach((configuration) => {
      const myToken = "cAtItvMAQqW6fSnacMUrXR:APA91bHoR6IIUEKzY4I1mOGH" +
      "ue0x7uzCo3H2czNXN5OxDTK3FAMtExBbvOGXN20rDWXOzyA5y3smm3stMFBBJ" +
      "4FuDEdLdBP-KnHDhCOnyJX5PNmgG0LaHIXp3evR_6UEcYC54__LgP0_";
      console.log("sending");
      const payload = {
        token: myToken,
        notification: {
          title: "cloud function demo ",
          body: "Automatic notification",
        },
        data: {
          body: "Automatic notification",
        },
      };
      fcm.send(payload)
          .then((response) => {
            // Response is a message ID string.

            console.log("Successfully sent message:", response);

            return {success: true};
          }).catch((error) => {
            return {error: error.code};
          });
    });
