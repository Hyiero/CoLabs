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
  if Meteor.settings.env.type isnt 'development'
    #console.log Meteor.settings
    {port, rootUrl, mongoUrl, bindIp, velocity} = Meteor.settings.env
    
    process.env.VELOCITY = velocity or 0
    process.env.PORT = port
    process.env.ROOT_URL = rootUrl
    process.env.MONGO_URL = mongoUrl
    process.env.BIND_IP = bindIp
  else
    Logger.enable()
    {velocity} = Meteor.settings.env
    process.env.VELOCITY = velocity or 0
