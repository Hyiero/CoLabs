Template.search.onCreated ->
  @subscribe 'allUsers'
  @subscribe 'allProjects'

findByUsersTags = (name, tags)->
  if tags.length is 0
    Meteor.users.find(
      name: $regex: "^#{name}.*", $options: 'i'
    ).fetch()
  else
    Meteor.users.find(
      name: $regex: "^#{name}.*", $options: 'i'
      tags: $all: tags
    ).fetch()

findByProjectTags = (name, tags)->
  if tags.length is 0
    Projects.find(
      name: $regex: "^#{name}.*", $options: 'i'
    ).fetch()
  else
    Projects.find(
      name: $regex: "^#{name}.*", $options: 'i'
      tags: $all: tags
    ).fetch()

Template.search.helpers
  filterResults: ->
    tags = Session.get('tagSearch') ? ''
    tags = tags.trim().split ' ' if tags.length > 0
    name = Session.get('nameSearch') ? ''
    type = Router.current().params.type
    results = switch type
      when 'users' then findByUsersTags(name, tags)
      when 'projects' then findByProjectTags(name, tags)
      else findByProjectTags(name, tags).concat findByUsersTags(name, tags)
    results = results.filter (item)->
      item.type is 'user' and item._id isnt Meteor.userId()


Template.searchTypeSelectors.helpers
  isUsers: -> Router.current().params.type is 'users'
  isProjects: -> Router.current().params.type is 'projects'
  isBoth: -> not Router.current().params.type?

Template.searchTypeSelectors.events
  "change .typeSelector": (event) ->
    $elem = $ event.currentTarget
    if $elem.is ':checked'
      val = $elem.val()
      if val != 'both'
        Session.set 'tagSearch', ''
        Session.set 'nameSearch', ''
        Router.go 'search', type: val
      else Router.go 'search'
