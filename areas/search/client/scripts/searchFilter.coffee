Template.searchFilter.events
  "input #searchFilter": (event) ->
    searchVal = $(event.currentTarget).val()
    Session.set "search", searchVal

  "click #clearFilter": (event) ->
    $('#searchFilter').val("")
    Session.set "search", ""

Template.searchFilter.helpers
  tags: ->
    tags = Session.get 'searchFilter'