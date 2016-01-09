###
# TODO: Google Analytics
process.env.METEOR_SETTINGS = {
  public: {
    ga: {
      account: "UA-65362043-1"
    }
  }
}

###

if Meteor.settings?.env?
  
  rootUrl = ''
  
  if Meteor.settings.env.type isnt 'development'
    
    {port, rootUrl, mongoUrl, bindIp, velocity} = Meteor.settings.env
    
    process.env.VELOCITY = velocity or 0
    process.env.PORT = port
    process.env.ROOT_URL = rootUrl
    process.env.MONGO_URL = mongoUrl
    process.env.BIND_IP = bindIp
    
  else
    do Logger.enable
    {velocity} = Meteor.settings.env
    process.env.VELOCITY = velocity or 0

  smtp = Meteor.settings.smtp
  (smtp[prop] = encodeURIComponent val) for prop, val of smtp
  
  process.env.MAIL_URL =
    "smtp://#{smtp.username}:#{smtp.password}@#{smtp.server}:#{smtp.port}"

  Accounts.emailTemplates.from = "CoLabs <no-reply@CoLabs.biz>"
  Accounts.emailTemplates.siteName = "CoLabs"
  Accounts.emailTemplates.verifyEmail.subject = (user) ->
    "Confirm Your Email Address at CoLabs"
    
  Accounts.emailTemplates.verifyEmail.text = (user, url) ->
   "Welcome, #{user.username}!
    
    Clicking on the following link will verify your email address: #{
      rootUrl + "#/" + (url.split '/#/').pop()
    }.
    After verifying, you will unlock the full capabilities of interacting with users and projects!
    
    Sincerely,
    The CoLabs Community"
