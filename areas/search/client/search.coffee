Template.search.onCreated ->
  @subscribe 'allUsers'
  @subscribe 'allProjects'

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
    $("#nameSearchFilter").val("")
    Session.set "nameSearch", ""
  "click .search-clear": (event) ->
    $(event.currentTarget).prev().val('').trigger('input')
    

Template.searchFilter.helpers
  tags: -> Session.get("tagSearch") ? ""
  name: -> Session.get("nameSearch") ? ""
  type: ->
    type = Session.get "typeSearch"
    unless type?
      type = "both"
      Session.set "typeSearch", type
    type

Template.searchTypeSelectors.helpers
  isUsers: -> 'users' is Session.get 'searchType'
  isProjects: -> 'projects' is Session.get 'searchType'
  isBoth: -> null is Session.get 'searchType'
  isUsersActive: -> if 'users' is Session.get 'searchType' then 'active'
  isProjectsActive: -> if 'projects' is Session.get 'searchType' then 'active'
  isBothActive: -> if null is Session.get 'searchType' then 'active'

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

UI.registerHelper "isUser", (result)-> result.type is "user"

UI.registerHelper "notLoggedInUser", (result)-> result._id isnt Meteor.userId()

UI.registerHelper "count", (list)-> list.length

findByUsersTags = (name, tags)->
  if tags.length is 0
    Meteor.users.find(
      name: { $regex: "^#{name}.*", $options: "i" }
    ).fetch()
  else
    Meteor.users.find(
      name: { $regex: "^#{name}.*", $options: "i" }
      tags: { $all: tags }
    ).fetch()

findByProjectTags = (name, tags)->
  if tags.length is 0
    Projects.find(
      name: { $regex: "^#{name}.*", $options: "i" }
    ).fetch()
  else
    Projects.find(
      name: { $regex: "^#{name}.*", $options: "i" }
      tags: { $all: tags }
    ).fetch()

Template.searchResults.helpers
  tags: -> if this.tags? then (this.tags).join ', '
  time: -> (new Date this.createdAt).toLocaleTimeString()
  isLoggedIn: -> Meteor.user()?
  isInviteSearch: -> this.type is 'invite'
  filterInput: ->
    nameInput = Session.get("nameSearch") ? ""
    tagInput = Session.get("tagSearch") ? ""
    "#{nameInput} | #{tagInput}"
  filterResults: ->
    tags = Session.get("tagSearch") ? ""
    tags = tags.trim().split " " if tags.length > 0
    name = Session.get("nameSearch") ? ""
    type = Session.get "typeSearch"
    switch type
      when "users" then findByUsersTags(name, tags)
      when "projects" then findByProjectTags(name, tags)
      else findByProjectTags(name, tags).concat findByUsersTags(name, tags)

Template.searchResults.events
  "click #messageContact": (event) ->
    userId = $(event.currentTarget).data 'user-id'
    Router.go "/inbox/#{userId}"
