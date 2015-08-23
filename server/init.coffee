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

# TODO: May not need hopefully at some point
process.env.PORT = 80
process.env.ROOT_URL = "http://qa.colabs.biz/"
process.env.MONGO_URL = "mongodb://qa.colabs.biz:82/meteor"
process.env.BIND_IP = "qa.colabs.biz"