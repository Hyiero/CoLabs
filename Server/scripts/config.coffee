Meteor.startup( ->
  smtp = {
    username: "colabstest1@gmail.com",
    password: "kentsucks",
    server: "smtp.gmail.com",
    port: 465
  }

  #Removes all users from Meteor. May be used for testing
  #Meteor.users.remove({});

  process.env.MAIL_URL = "smtp://"+encodeURIComponent(smtp.username) + ':' + encodeURIComponent(smtp.password) + '@' + encodeURIComponent(smtp.server) + ':' + smtp.port;

  Accounts.emailTemplates.from = "CoLabs <no-reply@CoLabs.com>"
  Accounts.emailTemplates.siteName = "CoLabs"
  Accounts.emailTemplates.subject = (user) ->
    "Confirm Your Email Address"
  Accounts.emailTemplates.text = (user,url) ->
    "Click on the following link to verify your email address: #{url}"
)