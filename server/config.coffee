Meteor.startup ->

  smtp = Meteor.settings.smtp
  (smtp[prop] = encodeURIComponent val) for prop, val of smtp
  process.env.MAIL_URL = "smtp://#{smtp.username}:#{smtp.password}@#{smtp.server}:#{smtp.port}"

  #Logger.enable()
  console.info process.env

  Accounts.emailTemplates.from = "CoLabs <no-reply@CoLabs.com>"
  Accounts.emailTemplates.siteName = "CoLabs"

  Accounts.emailTemplates.verifyEmail.subject = (user) ->
    "Confirm Your Email Address at CoLabs"

  Accounts.emailTemplates.verifyEmail.text = (user, url) ->
    "Welcome, #{user.username}!\n
    \n
    Clicking on the following link will verify your email address: #{url}.\n
    \n
    After verifying, you will unlock the full capabilities of interacting with users and projects!\n
    \n
    Sincerely,\n
    The CoLabs Community\n"
