Meteor.subscribe('allUsers')
Meteor.subscribe('allProjects')

findByUsersTags = (name, tags)->
  Meteor.users.find(
    name: { $regex: ".*"+name+".*"}
    tags: { $all: tags }
  ).fetch()

findByProjectTags = (name, tags)->
  Projects.find(
    name: { $regex: ".*"+name+".*"}
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
    filterResults = findByProjectTags(name, tags).concat(tempResults)