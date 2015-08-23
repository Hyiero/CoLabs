Template.searchFilter.events
  "input #searchFilter": (event) ->
    searchVal = $(event.currentTarget).val()
    Session.set "search", searchVal
  "input #nameSearchFilter": (event) ->
    searchVal = $(event.currentTarget).val()
    Session.set "nameSearch", searchVal

  "click #clearFilter": (event) ->
    $('#searchFilter').val("")
    Session.set "search", ""

  "click #nameClearFilter": (event) ->
    $('#nameSearchFilter').val("")
    Session.set "nameSearch", ""

Template.searchFilter.helpers
  tags: ->
    tags = Session.get 'searchFilter'
  name: ->
    name = Session.get 'nameSearchFilter'