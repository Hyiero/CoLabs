Router.configure
  load: ->
    $('html, body').animate scrollTop: 0
    @next()
  layoutTemplate: 'layout'
  landingTemplate: 'splash'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'
  waitOn: -> Meteor.subscribe 'thisUser'

searchTypes = [
  'users'
  'projects'
]

notificationTypes = [
  'general'
  'invites'
]

redirectIfNotLoggedIn = ->
  if Meteor.userId()? then @next()
  else Router.go '/'

redirectIfNotVerified = ->
  if Meteor.userId()? and CoLabs.isVerifiedUser() then @next()
  else Router.go '/'

redirectIfNotProjectAdmin = (projectId) ->
  if Meteor.userId()? and CoLabs.isProjectAdmin projectId then @next()
  else Router.go '/'

redirectIfNotAdmin = ->
  if Meteor.userId()? and CoLabs.isAdmin() then @next()
  else Router.go '/'


Router.map ->
  @route 'splash',
    path: '/'
    layoutTemplate: ''


  @route 'search',
    path: '/search/:type?'
    data: ->
      Session.set 'isInvitedUsers', false
      unless @params.type? then Session.set 'searchType', null
      else if @params.type not in searchTypes then Router.go '/search'
      else Session.set 'searchType', @params.type


  @route 'profile',
    path: '/profile'
    onBeforeAction: redirectIfNotLoggedIn
  
  @route 'profileEdit',
    path:'/profile/edit'
    onBeforeAction: redirectIfNotLoggedIn
    data: -> Session.set 'tags', Meteor.user().tags
  
  @route 'otherProfile',
    path: '/user/:username'


  @route 'inbox',
    path: '/inbox'
    onBeforeAction: redirectIfNotLoggedIn

  @route 'inboxChat',
    path: '/inbox/:username'
    onBeforeAction: redirectIfNotLoggedIn
    data: ->
      contact = Meteor.users.findOne(username: @params.username)._id
      Session.set 'contact', contact


  @route 'notifications',
    path: '/notifications/:type?'
    onBeforeAction: redirectIfNotLoggedIn
    data: ->
      unless @params.type? then Session.set 'notificationsType', null
      else if @params.type not in notificationTypes then Router.go '/notifications'
      else Session.set 'notificationsType', @params.type


  @route 'projects',
    path: '/projects'
    onBeforeAction: redirectIfNotVerified

  @route 'projectDashboard',
    path: '/project/:id'

  @route 'inviteUsers',
    path:'/inviteUsers'
    # TODO: only allow project admins to invite users
    #onBeforeAction: redirectIfNotProjectAdmin @params.id
    data: -> Session.set 'isInvitedUsers', true


  @route 'admin',
    path: '/admin'
    onBeforeAction: redirectIfNotAdmin

  @route 'adminPower',
    path: '/admin/power'
    onBeforeAction: redirectIfNotAdmin
