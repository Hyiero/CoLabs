Template.searchFilter.events
  "input #searchFilter": (event) ->
    searchVal = $(event.currentTarget).val()
    Session.set "tagSearch", searchVal
  "input #nameSearchFilter": (event) ->
    searchVal = $(event.currentTarget).val()
    Session.set "nameSearch", searchVal
  "click #clearFilter": (event) ->
    $("#searchFilter").val("")
    Session.set "tagSearch", ""
  "click #nameClearFilter": (event) ->
    console.log("click")
    $("#nameSearchFilter").val("")
    Session.set "nameSearch", ""

Template.searchFilter.helpers
  tags: ->
    tags = Session.get "tagSearch"
    tags ?= ""
  name: ->
    name = Session.get "nameSearch"
    name ?= ""
  type: ->
    type = Session.get "typeSearch"
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
        Router.go("search", {type: val})
      else
        Router.go("search")

UI.registerHelper "isUser", (result)->
  result.type == "user"

UI.registerHelper "notLoggedInUser", (result)->
  result._id != Meteor.userId()

findByUsersTags = (name, tags)->
  if tags.length == 0
    Meteor.users.find(
      name: { $regex: "^#{name}.*", $options: "i" }
    ).fetch()
  else
    Meteor.users.find(
      name: { $regex: "^#{name}.*", $options: "i" }
      tags: { $all: tags }
    ).fetch()

findByProjectTags = (name, tags)->
  if tags.length == 0
    Projects.find(
      name: { $regex: "^#{name}.*", $options: "i" }
    ).fetch()
  else
    Projects.find(
      name: { $regex: "^#{name}.*", $options: "i" }
      tags: { $all: tags }
    ).fetch()

Template.searchResults.helpers
  filterResults: ->
    tags = Session.get "tagSearch"
    name = Session.get "nameSearch"
    type = Session.get "typeSearch"
    if tags is undefined or tags == "" then tags = []
    else tags = tags.trim().split " "
    if name is undefined then name = ""
    switch type
      when "users" then findByUsersTags(name, tags)
      when "projects" then findByProjectTags(name, tags)
      else findByProjectTags(name, tags).concat findByUsersTags(name, tags)

Template.searchResults.events
  "click #messageContact": (event) ->
    userId = event.target.attributes["value"].value
    user = Meteor.users.findOne({_id:userId})
    Session.set "currentContact", user
