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
)
#Sends out email and then logs the person in. We should think about not allowing the user to log in
#until the email verification link has been clicked