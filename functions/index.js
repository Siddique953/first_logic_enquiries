const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);

exports.sendEmailFromWeb =
functions.firestore.document("/mail/{uid}").onCreate((event, context) =>{
  console.log("==========================================");
  const html =event.data().html;
  const status =event.data().status;
  const emailList =event.data().emailList;
  console.log(" ============ transporter function =====================");
  const nodemailer =require("nodemailer");
  const transporter = nodemailer.createTransport({
    host: "dedi.firstlogicmetalab.com",
    port: 465,
    ssl: true,
    auth: {
      user: "hr@firstlogicmetalab.com",
      pass: "FLHr@1234",
    },
  }
  );
  console.log(transporter);
  emailList.forEach(function(element) {
    const rslt = transporter.sendMail({
      from: '"HR-First Logic Meta Lab Pvt. Ltd" <hr@firstlogicmetalab.com>',
      to: element,
      subject: status,
      html: html,
    });
    console.log("**");
    console.log(rslt);
    return rslt;
  });
});