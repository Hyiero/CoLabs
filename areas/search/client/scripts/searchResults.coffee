Meteor.subscribe('allUsers')
Meteor.subscribe('allProjects')

findByUsersTags = (username, tags)->
  Meteor.users.find(
    username: { $regex: "^#{username}.*", $options: "i" }
    tags: { $all: tags }
  ).fetch()

findByProjectTags = (username, tags)->
  Projects.find(
    username: { $regex: "^#{username}.*", $options: "i" }
    tags: { $all: tags }
  ).fetch()

Template.searchResults.helpers
  filterResults: ->
    tags = Session.get 'search'
    name = Session.get 'nameSearch'
    if tags is undefined or tags.length == 0 then tags = ["searchable"]
    else tags = tags.trim().split ' '
    if name is undefined then name = ''
    tempResults = findByUsersTags(name, tags)
    findByProjectTags(name, tags).concat(tempResults)

Template.searchResults.events
  "click #messageContact": (event) ->
    userId = event.target.attributes['value'].value
    user = Meteor.users.findOne({_id:userId})
    console.log(user)
    Session.set "currentContact", user

