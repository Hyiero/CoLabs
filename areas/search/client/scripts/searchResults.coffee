Template.searchResults.helpers
  tags: ->
    tags = Session.get 'search'
    if tags is undefined or tags.length == 0 then tags = []
    else tags = tags.trim().split ' '
    tags

Meteor.subscribe('users')