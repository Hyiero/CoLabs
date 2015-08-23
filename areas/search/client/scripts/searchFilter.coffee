Template.searchFilter.events
  "input #searchFilter": (event) ->
    searchVal = $(event.currentTarget).val()
    Session.set "search", searchVal

Template.searchFilter.helpers
  tags: ->
    tags = Session.get 'searchFilter'