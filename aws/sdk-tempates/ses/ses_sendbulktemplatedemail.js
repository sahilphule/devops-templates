// // Load the AWS SDK for Node.js
// var AWS = require("aws-sdk");
// // Set the region
// AWS.config.update({ region: "REGION" });

// // Create sendBulkTemplatedEmail params
// var params = {
//   Destinations: [
//     /* required */
//     {
//       Destination: {
//         /* required */
//         CcAddresses: [
//           "EMAIL_ADDRESS",
//           /* more items */
//         ],
//         ToAddresses: [
//           "EMAIL_ADDRESS",
//           "EMAIL_ADDRESS",
//           /* more items */
//         ],
//       },
//       ReplacementTemplateData: '{ "REPLACEMENT_TAG_NAME":"REPLACEMENT_VALUE" }',
//     },
//   ],
//   Source: "EMAIL_ADDRESS" /* required */,
//   Template: "TEMPLATE_NAME" /* required */,
//   DefaultTemplateData: '{ "REPLACEMENT_TAG_NAME":"REPLACEMENT_VALUE" }',
//   ReplyToAddresses: ["EMAIL_ADDRESS"],
// };

// // Create the promise and SES service object
// var sendPromise = new AWS.SES({ apiVersion: "2010-12-01" })
//   .sendBulkTemplatedEmail(params)
//   .promise();

// // Handle promise's fulfilled/rejected states
// sendPromise
//   .then(function (data) {
//     console.log(data);
//   })
//   .catch(function (err) {
//     console.log(err, err.stack);
//   });

require("dotenv").config();
const { SESClient, SendBulkTemplatedEmailCommand } = require("@aws-sdk/client-ses");

const sesClient = new SESClient({ region: process.env.AWS_REGION });

const sendBulkTemplatedEmail = async (recipients, templateName) => {
  if (!recipients || recipients.length === 0) {
    console.error("No recipients provided.");
    return;
  }

  const params = {
    Destinations: recipients.map(({ email, cc, templateData }) => ({
      Destination: {
        ToAddresses: [email],
        CcAddresses: cc ? [cc] : [],
      },
      ReplacementTemplateData: JSON.stringify(templateData),
    })),
    Source: process.env.SES_SENDER_EMAIL,
    Template: templateName,
    DefaultTemplateData: JSON.stringify({
      name: "User",
      appointment_date: "N/A",
    }),
    ReplyToAddresses: [process.env.SES_REPLY_TO_EMAIL],
  };

  try {
    const command = new SendBulkTemplatedEmailCommand(params);
    const data = await sesClient.send(command);
    console.log("Bulk email sent successfully:", data.Status);

    // Log failed emails
    data.Status.forEach((status, index) => {
      if (status.Status !== "Success") {
        console.error(`Email to ${recipients[index].email} failed:`, status);
      }
    });

  } catch (err) {
    console.error("Email sending failed:", err);
  }
};

// Example Usage
sendBulkTemplatedEmail(
  [
    { email: "recipient1@example.com", cc: "cc1@example.com", templateData: { name: "John", appointment_date: "March 1, 2025" } },
    { email: "recipient2@example.com", templateData: { name: "Jane", appointment_date: "March 2, 2025" } },
  ],
  "YourSESTemplate"
);
