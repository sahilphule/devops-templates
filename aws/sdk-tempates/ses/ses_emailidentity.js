require("dotenv").config();
const { 
  SESClient, 
  VerifyEmailIdentityCommand, 
  ListIdentitiesCommand, 
  GetIdentityVerificationAttributesCommand, 
  DeleteIdentityCommand 
} = require("@aws-sdk/client-ses");

const sesClient = new SESClient({ region: process.env.AWS_REGION });

/**
 * Verify an email identity in AWS SES
 * @param {string} email - The email address to verify
 */
const verifyEmailIdentity = async (email) => {
  if (!email) return console.error("Email address is required.");

  try {
    const command = new VerifyEmailIdentityCommand({ EmailAddress: email });
    await sesClient.send(command);
    console.log(`Verification email sent to: ${email}`);
  } catch (error) {
    console.error("Error verifying email:", error);
  }
};

/**
 * List all verified email identities
 */
const listEmailIdentities = async () => {
  try {
    const command = new ListIdentitiesCommand({ IdentityType: "EmailAddress" });
    const response = await sesClient.send(command);
    console.log("Verified Identities:", response.Identities);
  } catch (error) {
    console.error("Error fetching identities:", error);
  }
};

/**
 * Check the verification status of an email identity
 * @param {string} email - The email address to check
 */
const checkVerificationStatus = async (email) => {
  if (!email) return console.error("Email address is required.");

  try {
    const command = new GetIdentityVerificationAttributesCommand({ Identities: [email] });
    const response = await sesClient.send(command);
    console.log(`Verification Status for ${email}:`, response.VerificationAttributes[email]);
  } catch (error) {
    console.error("Error checking verification status:", error);
  }
};

/**
 * Delete an email identity from AWS SES
 * @param {string} email - The email address to delete
 */
const deleteEmailIdentity = async (email) => {
  if (!email) return console.error("Email address is required.");

  try {
    const command = new DeleteIdentityCommand({ Identity: email });
    await sesClient.send(command);
    console.log(`Successfully deleted identity: ${email}`);
  } catch (error) {
    console.error("Error deleting identity:", error);
  }
};

// Example Usage
verifyEmailIdentity("your-email@example.com");
listEmailIdentities();
checkVerificationStatus("your-email@example.com");
deleteEmailIdentity("your-email@example.com");
