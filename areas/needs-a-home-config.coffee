if Meteor.isClient
  Accounts.ui.config
    passwordSignupFields: "USERNAME_AND_EMAIL"
    forceEmailLowercase: true
    forceUsernameLowercase: true
    forcePasswordLowercase: true
