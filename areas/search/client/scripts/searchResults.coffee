Meteor.subscribe('allUsers')
Meteor.subscribe('allProjects')

findByUsersTags = (tags)->
  Meteor.users.find(
    tags: { $all: tags }
  ).fetch()

findByProjectTags = (tags)->
  Projects.find(
    tags: { $all: tags }
  ).fetch()

Template.searchResults.helpers
  filterResults: ->
    tags = Session.get 'search'
    if tags is undefined or tags.length == 0 then tags = ["searchable"]
    else tags = tags.trim().split ' '
    tempResults = findByUsersTags(tags)
    filterResults = findByProjectTags(tags).concat(tempResults)