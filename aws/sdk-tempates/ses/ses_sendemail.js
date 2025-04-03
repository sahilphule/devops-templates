// // Load the AWS SDK for Node.js
// var AWS = require("aws-sdk");
// // Set the region
// AWS.config.update({ region: "REGION" });

// // Create sendEmail params
// var params = {
//   Destination: {
//     /* required */
//     CcAddresses: [
//       "EMAIL_ADDRESS",
//       /* more items */
//     ],
//     ToAddresses: [
//       "EMAIL_ADDRESS",
//       /* more items */
//     ],
//   },
//   Message: {
//     /* required */
//     Body: {
//       /* required */
//       Html: {
//         Charset: "UTF-8",
//         Data: "HTML_FORMAT_BODY",
//       },
//       Text: {
//         Charset: "UTF-8",
//         Data: "TEXT_FORMAT_BODY",
//       },
//     },
//     Subject: {
//       Charset: "UTF-8",
//       Data: "Test email",
//     },
//   },
//   Source: "SENDER_EMAIL_ADDRESS" /* required */,
//   ReplyToAddresses: [
//     "EMAIL_ADDRESS",
//     /* more items */
//   ],
// };

// // Create the promise and SES service object
// var sendPromise = new AWS.SES({ apiVersion: "2010-12-01" })
//   .sendEmail(params)
//   .promise();

// // Handle promise's fulfilled/rejected states
// sendPromise
//   .then(function (data) {
//     console.log(data.MessageId);
//   })
//   .catch(function (err) {
//     console.error(err, err.stack);
//   });

require("dotenv").config();
const { SESClient, SendEmailCommand } = require("@aws-sdk/client-ses");

const sesClient = new SESClient({ region: process.env.AWS_REGION });

const sendEmail = async (toEmail, ccEmail, subject, htmlBody, textBody) => {
  if (!toEmail || !subject || !htmlBody || !textBody) {
    console.error("Missing required parameters.");
    return;
  }

  const params = {
    Destination: {
      ToAddresses: [toEmail],
      CcAddresses: ccEmail ? [ccEmail] : [],
    },
    Message: {
      Subject: { Charset: "UTF-8", Data: subject },
      Body: {
        Html: { Charset: "UTF-8", Data: htmlBody },
        Text: { Charset: "UTF-8", Data: textBody },
      },
    },
    Source: process.env.SES_SENDER_EMAIL,
    ReplyToAddresses: [process.env.SES_REPLY_TO_EMAIL],
  };

  try {
    const command = new SendEmailCommand(params);
    const data = await sesClient.send(command);
    console.log("Email sent! Message ID:", data.MessageId);
  } catch (err) {
    console.error("Email sending failed:", err);
  }
};

// Example Usage
sendEmail(
  "recipient@example.com",
  "cc@example.com",
  "Alert",
  "<h1>Critical Health Update</h1><p>Your report is ready.</p>",
  "Critical Health Update - Your report is ready."
);
