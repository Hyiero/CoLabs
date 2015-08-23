Meteor.subscribe('allUsers')

findByTags = (tags)->
  Meteor.users.find
    interests: { $all: tags }

Template.searchResults.helpers
  filterResults: ->
    tags = Session.get 'search'
    if tags is undefined or tags.length == 0 then tags = ["users"]
    else tags = tags.trim().split ' '
    filterResults = findByTags(tags)