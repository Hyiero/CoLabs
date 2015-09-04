Template.searchFilter.events
  "input #searchFilter": (event) ->
    searchVal = $(event.currentTarget).val()
    Session.set "tagSearch", searchVal
  "input #nameSearchFilter": (event) ->
    searchVal = $(event.currentTarget).val()
    Session.set "nameSearch", searchVal
  "click #clearFilter": (event) ->
    $('#searchFilter').val("")
    Session.set "tagSearch", ""
  "click #nameClearFilter": (event) ->
    console.log("click")
    $('#nameSearchFilter').val("")
    Session.set "nameSearch", ""

Template.searchFilter.helpers
  tags: ->
    tags = Session.get 'tagSearch'
    tags ?= ""
  name: ->
    name = Session.get 'nameSearch'
    name ?= ""
  type: ->
    type = Session.get 'typeSearch'
    unless type?
      type = "both"
      Session.set "typeSearch", type
    type

Template.searchTypeSelectors.events
  "change .typeSelector": (event) ->
    $elem = $ event.currentTarget
    if $elem.is(":checked")
      val = $elem.val()
      Session.set "typeSearch", val
      if val != "both"
        Session.set "tagSearch", ""
        Session.set "nameSearch", ""
        Router.go('search', {type: val})
      else
        Router.go('search')
