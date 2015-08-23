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

if Meteor.settings and
  Meteor.settings.env and
  Meteor.settings.type isnt 'development'
    console.log Meteor.settings
    {port, rootUrl, mongoUrl, bindIp} = Meteor.settings.env
    process.env.PORT = port
    process.env.ROOT_URL = rootUrl
    process.env.MONGO_URL = mongoUrl
    process.env.BIND_IP = bindIp
