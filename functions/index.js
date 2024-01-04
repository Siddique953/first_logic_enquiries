const functions = require("firebase-functions");const admin = require("firebase-admin");admin.initializeApp(functions.config().firebase);exports.sendEmailFromWeb =functions.firestore.document("/mail/{uid}").onCreate((event, context) =>{  console.log("==========================================");  const html =event.data().html;  const status =event.data().status;  const emailList =event.data().emailList;  const attachmentUrl =event.data().att;  console.log(" ============ transporter function =====================");  const nodemailer =require("nodemailer");  const transporter = nodemailer.createTransport({//    host: "firstlogicmetalab.com",    host: "mail.firstlogicmetalab.com",    port: 465,//    port: 587,    ssl: true,    auth: {      user: "hr@firstlogicmetalab.com",      pass: "FirstLogic@1123",    },  }  );  console.log(transporter);  console.log("*FIRST CONDITION*");  console.log(Array.isArray(attachmentUrl));  console.log("*SECOND*");  console.log(attachmentUrl.length > 0);  if(Array.isArray(attachmentUrl) && attachmentUrl.length > 0)  {    console.log("******* FIRST IF ********");    emailList.forEach(function(element) {        console.log("******* LIST OF ATTACHMENT ********");        console.log(element);        const attachments = attachmentUrl.map(url => {            return {              filename: 'Attachment.pdf', // You can adjust the filename as needed              path: url            };          });        const rslt = transporter.sendMail({          from: '"HR-First Logic Meta Lab Pvt. Ltd" <hr@firstlogicmetalab.com>',          to: element,          subject: status,          html: html,          attachments: attachments,          // attachments: [{          //   filename: 'PaySlip.pdf',          //   path: attachmentUrl          // }],        });        console.log("**");        console.log(rslt);        return rslt;      });  } else if(attachmentUrl === "" || attachmentUrl.length === 0)  {    console.log("******* SECOND IF ********");    emailList.forEach(function(element) {        console.log("******* No attachment ********");        console.log("******* OR ********");        console.log("******* EMPTY ATTACHMENTS ********");        console.log(element);        const rslt = transporter.sendMail({          from: '"HR-First Logic Meta Lab Pvt. Ltd" <hr@firstlogicmetalab.com>',          to: element,          subject: status,          html: html,          // attachments: [{          //   filename: 'PaySlip.pdf',          //   path: attachmentUrl          // }],        });        console.log("**");        console.log(rslt);        return rslt;      });  } else {    console.log("******* ELSE ********");    emailList.forEach(function(element) {        console.log("******* With attachment ********");        console.log(element);        const rslt = transporter.sendMail({          from: '"HR-First Logic Meta Lab Pvt. Ltd" <hr@firstlogicmetalab.com>',          to: element,          subject: status,          html: html,           attachments: [{             filename: 'PaySlip.pdf',             path: attachmentUrl           }],        });        console.log("**");        console.log(rslt);        return rslt;      });  }});// Cloud Function to send a notification to a list of device IDsexports.sendNotification = functions.firestore.document('leaveRequest/{uid}').onCreate(async (snapshot, context) => {    console.log('================1================');    // Get the notification data    const data = snapshot.data();    console.log('================2================');    // Get the list of device IDs from the notification data    let deviceIds = [];    if(data.teamLead == "" || data.teamLead == null){      deviceIds=[data.reportingManager];    } else {      deviceIds=[data.teamLead];    }    console.log('================3================');    // Get the message from the notification data    const name = data.name;    console.log('================4================');    // Set up the notification payload    const payload = {notification: {      title: 'Leave Request',      body: 'Leave request from '+name    },    data: {      "title": 'Leave Request',      "body": 'Leave request from '+name,      "click_action": "FLUTTER_NOTIFICATION_CLICK",      "sound": "default",      "status": "done",      "screen": context.params.uid,      "extraData": "req",    },    };    console.log('================5================');    // Send the notification to each device ID using the Firebase Cloud Messaging API    for (const deviceId of deviceIds) {        console.log('================for================');        console.log('================for================'+deviceId);        try {            console.log('================try================');            const tokenSnapshot = await admin.firestore().collection('employees').doc(deviceId).get();            console.log('================try Doc Get================');            if (tokenSnapshot.exists) {                console.log('================try IF 1================');                const tokenData = tokenSnapshot.data();                console.log('================try IF 2================');                const token = tokenData.token;                console.log('================try IF 3================');                console.log(token);                await admin.messaging().sendToDevice(token, payload);                console.log('Notification sent to device ID: '+deviceId);            } else {                console.log('================try ELSE================');                console.log('No token found for device ID: '+deviceId);            }        } catch (error) {            console.log('================CATCH================');            console.error('Error sending notification to device ID:' +deviceId, error);        }    }});exports.sendLeaveReqReplyNotification = functions.firestore  .document('leaveRequest/{docId}')  .onUpdate(async (change, context) => {    const newValueA = change.after.data().accepted;    const oldValueA = change.before.data().accepted;    const newValueR = change.after.data().rejected;    const oldValueR = change.before.data().rejected;    const empId = change.before.data().empId;    let title ="";    let body ="";    let sendNotification = false;    let tokens =[];    if (newValueA == true && newValueA != oldValueA) {      sendNotification = true;      title = "Request Accepted";      body = "Your request for leave is accepted";    } else if(newValueR == true && newValueR != oldValueR){      sendNotification = true;      title = "Request Rejected";      body = "Your request for leave is rejected";    }    const screen = context.params.uid ? context.params.uid.toString() : '';    const payload = {      notification: {        title: title,        body: body,      },      data: {        "title": 'Leave Request Reply',        "body": 'Leave request Reply from admin',        "click_action": "FLUTTER_NOTIFICATION_CLICK",        "sound": "default",        "status": "done",        "screen": screen,        "extraData": "reply",      },    };    const options = {      priority: 'high',      timeToLive: 60 * 60 * 24, // 24 hours    };    if (sendNotification) {      const doc = await admin.firestore().collection("employees").doc(empId).get();      if (doc.exists) {        tokens = doc.get("token");      }      if (tokens.length > 0) {        console.log("Sending notification with payload:", payload);        return admin.messaging().sendToDevice(tokens, payload, options)          .then(function(response) {            console.log("Notification sent successfully:", response);          })          .catch(function(error) {            console.log("Notification sent failed:", error);          });      } else {        console.log("No tokens found for employee with ID:", empId);        return null;      }    } else {      console.log("No notification sent");      return null;    }});exports.sendLeaveReqNotificationToHrAndPm = functions.firestore  .document('leaveRequest/{docId}')  .onUpdate(async (change, context) => {    console.log('================LOG 1================');    const newValueHr = change.after.data().hrView;    console.log('================LOG 2================' + newValueHr);    const oldValueHr = change.before.data().hrView;    console.log('================LOG 3================'  + oldValueHr);    const newValuePm = change.after.data().pmView;    console.log('================LOG 4================'+newValuePm);    const oldValuePm = change.before.data().pmView;    console.log('================LOG 5================'+ oldValuePm);    const name = change.before.data().name;    console.log('================LOG 6================'+name);    const empId = change.before.data().empId;    console.log('================LOG 7================'+empId);    let title ="";    let body ="";    let tokenIds =[];    let sendNotification = false;    let tokens =[];    if (newValueHr == true && newValueHr != oldValueHr) {      console.log('================LOG 7=========IF======='+empId);      sendNotification = true;      title = "Received a Leave Request";      body = "Received a Leave Request From " + name;      tokenIds = change.before.data().managers;    } else if (newValuePm == true && oldValuePm != newValuePm) {      console.log('================LOG 7======ELSE IFF=========='+empId);      sendNotification = true;      title = "Received a Leave Request";      body = "Received a Leave Request From " + name;      tokenIds = [change.before.data().reportingManager];    }    const screen = context.params.uid ? context.params.uid.toString() : '';    const payload = {      notification: {        title: title,        body: body,      },      data: {        "title": title,        "body": body,        "click_action": "FLUTTER_NOTIFICATION_CLICK",        "sound": "default",        "status": "done",        "screen": screen,        "extraData": "req",      },    };    const options = {      priority: 'high',      timeToLive: 60 * 60 * 24, // 24 hours    };    if (sendNotification) {      for (const deviceId of tokenIds) {              console.log('================for================');              console.log('================for================'+deviceId);              try {                  console.log('================try================');                  const tokenSnapshot = await admin.firestore().collection('employees')                    .doc(deviceId).get();                  console.log('================try Doc Get================');                  if (tokenSnapshot.exists) {                      console.log('================try IF 1================');                      const tokenData = tokenSnapshot.data();                      console.log('================try IF 2================');                      const token = tokenData.token;                      console.log('================try IF 3================');                      console.log(token);                      await admin.messaging().sendToDevice(token, payload);                      console.log('Notification sent to device ID: '+deviceId);                  } else {                      console.log('================try ELSE================');                      console.log('No token found for device ID: '+deviceId);                  }              } catch (error) {                  console.log('================CATCH================');                  console.error('Error sending notification to device ID:' +deviceId, error);              }          }    } else {      console.log("No notification sent");      return null;    }});exports.sendAttendanceNotification = functions.firestore  .document('sendNotification/{docId}')  .onCreate(async (snapshot, context) => {      console.log('================1================');      // Get the notification data      const data = snapshot.data();      const screen = context.params.uid || '';      console.log('================3================');      // Get the message from the notification data      const name = data.name;      console.log('================4================');      // Set up the notification payload      const payload = {notification: {        title: 'Attendance Update',        body: "New attendance added."      },      data: {        "title": 'Attendance Update',        "body": "New attendance for "+name+" added.",        "click_action": "FLUTTER_NOTIFICATION_CLICK",        "sound": "default",        "status": "done",        "screen": String(screen),        "extraData": "attendance-"+name,      },      };      console.log('================5================');      // Send the notification to each device ID using the Firebase Cloud Messaging API          try {              console.log('================try================');//              const tokenSnapshot = await admin.firestore()//                .collection('employees').where("name","==","ABOOBACKER SIDDIQUE").get();               const tokenSnapshot = await admin.firestore()                 .collection('employees').where("delete","==",false).get();                console.log('================try Doc Get================');                for(const i in tokenSnapshot.docs) {                    console.log('================try IF 1================');                    const tokenData = tokenSnapshot.docs[i].data();                    console.log('================try IF 2================');                    const token = tokenData.token;                    console.log('================try IF 3================');                    console.log(token);                    await admin.messaging().sendToDevice(token, payload);                }          } catch (error) {              console.log('================CATCH================');              console.error('Error sending notification to device ID:' + error);          }  });