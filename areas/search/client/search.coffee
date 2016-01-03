Template.search.onCreated ->
  @subscribe 'allUsers'
  @subscribe 'allProjects'

findByUsersTags = (name, skills, interests)->
  if skills.length is 0 and interests.length is 0
    Meteor.users.find(
      name: $regex: "^#{name}.*", $options: 'i'
    ).fetch()
  else if interests.length is 0
    Meteor.users.find(
      name: $regex: "^#{name}.*", $options: 'i'
      skills: $all: skills
    ).fetch()
  else if skills.length is 0
    Meteor.users.find(
      name: $regex: "^#{name}.*", $options: 'i'
      interests: $all: interests
    ).fetch()
  else
    Meteor.users.find(
      name: $regex: "^#{name}.*", $options: 'i'
      skills: $all: skills
      interests: $all: interests
    ).fetch()

findByProjectTags = (name, skills, interests)->
  if skills.length is 0 and interests.length is 0
    Projects.find(
      name: $regex: "^#{name}.*", $options: 'i'
    ).fetch()
  else if interests.length is 0
    Projects.find(
      name: $regex: "^#{name}.*", $options: 'i'
      skills: $all: skills
    ).fetch()
  else if skills.length is 0
    Projects.find(
      name: $regex: "^#{name}.*", $options: 'i'
      interests: $all: interests
    ).fetch()
  else
    Projects.find(
      name: $regex: "^#{name}.*", $options: 'i'
      skills: $all: skills
      interests: $all: interests
    ).fetch()

Template.search.helpers
  filterResults: ->
    skills = (Session.get 'skillSearch') ? ''
    skills = skills.trim().split ' ' if skills.length > 0
    interests = (Session.get 'interestSearch') ? ''
    interests = interests.trim().split ' ' if interests.length > 0
    name = (Session.get 'nameSearch') ? ''
    type = Router.current().params.type
    results = switch type
      when 'users' then findByUsersTags(name, skills, interests)
      when 'projects' then findByProjectTags(name, skills, interests)
      else findByProjectTags(name, skills, interests).concat findByUsersTags(name, skills, interests)
    results = results.filter (item)-> item._id isnt Meteor.userId()


Template.searchTypeSelectors.helpers
  isUsers: -> Router.current().params.type is 'users'
  isProjects: -> Router.current().params.type is 'projects'
  isBoth: -> not Router.current().params.type?

Template.searchTypeSelectors.events
  'change .typeSelector': (event) ->
    $elem = $ event.currentTarget
    if $elem.is ':checked'
      val = $elem.val()
      if val != 'both'
        Session.set 'skillSearch', ''
        Session.set 'interestSearch', ''
        Session.set 'nameSearch', ''
        Router.go 'search', type: val
      else Router.go 'search'
