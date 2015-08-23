Meteor.subscribe('allUsers')
Meteor.subscribe('allProjects')

findByUsersTags = (username, tags)->
  Meteor.users.find(
    username: { $regex: "^"+username+".*", $options: "i"}
    tags: { $all: tags }
  ).fetch()

findByProjectTags = (username, tags)->
  Projects.find(
    username: { $regex: "^"+username+".*", $options: "i"}
    tags: { $all: tags }
  ).fetch()

Template.searchResults.helpers
  filterResults: ->
    tags = Session.get 'search'
    username = Session.get 'usernameSearch'
    if tags is undefined or tags.length == 0 then tags = ["searchable"]
    else tags = tags.trim().split ' '
    if username is undefined then username = ''
    tempResults = findByUsersTags(username, tags)
    filterResults = findByProjectTags(username, tags).concat(tempResults)

Template.searchResults.events
  "click #messageContact": (event) ->
    userId = event.target.attributes['value'].value
    user=Meteor.users.findOne({_id:userId})
    console.log(user)
    Session.set "currentContact", user

