Meteor.subscribe('allUsers')
Meteor.subscribe('allProjects')

UI.registerHelper 'containsUser', (tags)->
  'user' in tags

UI.registerHelper 'notLoggedInUser', (result)->
  result._id != Meteor.userId()

findByUsersTags = (name, tags)->
  Meteor.users.find(
    name: { $regex: "^#{name}.*", $options: "i" }
    tags: { $all: tags }
  ).fetch()

findByProjectTags = (name, tags)->
  Projects.find(
    name: { $regex: "^#{name}.*", $options: "i" }
    tags: { $all: tags }
  ).fetch()

Template.searchResults.helpers
  filterResults: ->
    tags = Session.get 'search'
    name = Session.get 'nameSearch'
    if tags is undefined or tags.length == 0 then tags = ["searchable"]
    else tags = tags.trim().split ' '
    if name is undefined then name = ''
    findByProjectTags(name, tags).concat findByUsersTags(name, tags)

Template.searchResults.events
  "click #messageContact": (event) ->
    userId = event.target.attributes['value'].value
    user = Meteor.users.findOne({_id:userId})
    Session.set "currentContact", user

