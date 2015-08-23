@Users = new Mongo.Collection('testUsers')

userSeeds = [
  {
    name: "Juan",
    image:"honeymoon-mars.jpg"
    age:5
    interests:["swastikas","development","etc"]
  },
  {
    name: "Brandon"
    image: "illudium-q36.jpg"
    age:10
    interests:["none"]
  },
  {
    name: "Christopher"
    image: "johnny-liftoff.jpg"
    age: 37
    interests: ["users", "projects", "tags"]
  }
]

if Meteor.isServer
  if Users.find().count()==0
    for user in userSeeds
      Users.insert(user)

Users.GetTestUser = ()->
    Users.findOne({name:"Juan"})

Users.GetUserByName = (name)->
  Users.findOne({name:name})






