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

if Meteor.settings?env?type isnt 'development'
  {port, rootUrl, mongoUrl, bindIp} = Meteor.settings.env
  process.env.PORT = port
  process.env.ROOT_URL = rootUrl
  process.env.MONGO_URL = mongoUrl
  process.env.BIND_IP = bindIp

console.log Meteor.settings