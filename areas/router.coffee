Router.configure
  load: ->
    $('html, body').animate scrollTop: 0
    @next()
  landingTemplate: "splash"
  loadingTemplate: "loading"
  notFoundTemplate: "notFound"
  waitOn: -> Meteor.subscribe 'thisUser'

redirectIfNotUser = ->
  if Meteor.userId()? then @next()
  else Router.go '/'

redirectIfNotVerified = ->
  if Meteor.userId()? and CoLabs.isVerifiedUser() then @next()
  else Router.go '/'

redirectIfNotAdmin = ->
  if Meteor.userId()? and CoLabs.isAdmin() then @next()
  else Router.go '/'

Router.map ->
  @route 'splash', {
    path: '/'
  }

  @route 'profile', {
    path: '/profile'
    onBeforeAction: redirectIfNotUser
    data: -> user: Meteor.user()
  }
  
  @route 'profileEdit', {
    path:'/profile/edit'
    onBeforeAction: redirectIfNotUser
    data:->
      user: Meteor.user()
      setSession:->
        Session.set "tags", Meteor.user().tags
  }
  
  @route 'otherProfile', {
    path: '/:username/profile'
    data:->
      username = @params.username
      user: Meteor.users.findOne username:username
  }
  
  @route 'search', {
    path: '/search/:type?'
    data: ->
      if @params.type?
        Session.set 'searchType', @params.type
      else
        Session.set 'searchType', null
  }
  
  @route 'admin', {
    path: '/admin'
    onBeforeAction: redirectIfNotAdmin
  }

  @route 'adminPower', {
    path: '/admin/power'
    onBeforeAction: redirectIfNotAdmin
  }
  
  @route 'projects', {
    path: '/projects'
    onBeforeAction: redirectIfNotVerified
  }
  
  @route 'projectDashboard', {
    path: '/projects/:id'
    onBeforeAction: redirectIfNotVerified
  }

  @route 'inbox', {
    path: '/inbox'
    onBeforeAction: redirectIfNotUser
  }

  @route 'inboxChat', {
    path: '/inbox/:username'
    onBeforeAction: redirectIfNotUser
    data: ->
      contact = Meteor.users.findOne(username: @params.username)._id
      Session.set 'contact', contact
  }
  
  @route 'notifications', {
    path: '/notifications'
    waitOn: -> [
      (Meteor.subscribe 'userInvitations'),
      (Meteor.subscribe 'allProjects')
    ]
    onBeforeAction: redirectIfNotUser
    data: ->
      notifications: -> Notifications.find(),
      invitations: ->
        CoLabs.formatInvitations Invitations.find().fetch()
  }
  
  @route 'inviteUsers', {
    path:'/inviteUsers'
    waitOn: ->
      Meteor.subscribe 'allInvitations'
    onBeforeAction: redirectIfNotVerified
  }