// // Load the AWS SDK for Node.js
// var AWS = require("aws-sdk");
// // Set the region
// AWS.config.update({ region: "REGION" });

// // Create sendTemplatedEmail params
// var params = {
//   Destination: {
//     /* required */
//     CcAddresses: [
//       "EMAIL_ADDRESS",
//       /* more CC email addresses */
//     ],
//     ToAddresses: [
//       "EMAIL_ADDRESS",
//       /* more To email addresses */
//     ],
//   },
//   Source: "EMAIL_ADDRESS" /* required */,
//   Template: "TEMPLATE_NAME" /* required */,
//   TemplateData: '{ "REPLACEMENT_TAG_NAME":"REPLACEMENT_VALUE" }' /* required */,
//   ReplyToAddresses: ["EMAIL_ADDRESS"],
// };

// // Create the promise and SES service object
// var sendPromise = new AWS.SES({ apiVersion: "2010-12-01" })
//   .sendTemplatedEmail(params)
//   .promise();

// // Handle promise's fulfilled/rejected states
// sendPromise
//   .then(function (data) {
//     console.log(data);
//   })
//   .catch(function (err) {
//     console.error(err, err.stack);
//   });

require("dotenv").config();
const { SESClient, SendTemplatedEmailCommand } = require("@aws-sdk/client-ses");

const sesClient = new SESClient({ region: process.env.AWS_REGION });

const sendTemplatedEmail = async (toEmail, ccEmail, templateData) => {
  if (!toEmail || !templateData) {
    console.error("Missing required parameters.");
    return;
  }

  const params = {
    Destination: {
      ToAddresses: [toEmail],
      CcAddresses: ccEmail ? [ccEmail] : [],
    },
    Source: process.env.SES_SENDER_EMAIL,
    Template: process.env.SES_TEMPLATE_NAME,
    TemplateData: JSON.stringify(templateData),
    ReplyToAddresses: [process.env.SES_REPLY_TO_EMAIL],
  };

  try {
    const command = new SendTemplatedEmailCommand(params);
    const data = await sesClient.send(command);
    console.log("Templated email sent! Message ID:", data.MessageId);
  } catch (err) {
    console.error("Email sending failed:", err);
  }
};

// Example Usage
sendTemplatedEmail(
  "recipient@example.com",
  "cc@example.com",
  { name: "John Doe", appointment_date: "March 1, 2025" }
);
