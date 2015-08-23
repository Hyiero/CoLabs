Template.searchFilter.events
  "input #searchFilter": (event) ->
    searchVal = $(event.currentTarget).val()
    Session.set "search", searchVal
