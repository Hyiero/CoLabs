Router.configure
  load: ->
    $('html, body').animate scrollTop: 0
    @next()
  landingTemplate: "splash"
  loadingTemplate: "loading"
  notFoundTemplate: "notFound"
  #waitOn: -> Meteor.subscribe('recordSetThatYouNeedNoMatterWhat')

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
  
  @route 'loading', {
    path: '/loading'
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
    waitOn: () ->
      Meteor.subscribe 'myProjects'
    onBeforeAction: redirectIfNotVerified
    data: ->
      projects = Projects.find users: Meteor.userId()
      # if not projects then Session.set 'editProject', true
      debug: projects.count()
      message: "Projects Page"
      projects: projects
      projectName: Session.get "projectName"
      projectDescription: Session.get "projectDescription"
  }
  
  @route 'projectDashboard', {
    path: '/projects/:id'
    waitOn: () ->
      Meteor.subscribe 'project', @params.id
    onBeforeAction: redirectIfNotVerified
    data: -> project: Projects.findOne()
  }

  @route 'inbox', {
    path: '/inbox'
    onBeforeAction: redirectIfNotUser
  }

  @route 'inboxChat', {
    path: '/inbox/:id'
    onBeforeAction: redirectIfNotUser
  }
  
  @route 'notifications', {
    path: '/notifications'
    waitOn: -> [
      (Meteor.subscribe 'userInvitations'),
      (Meteor.subscribe 'allProjects')
    ]
    onBeforeAction: redirectIfNotUser
    data: ->
      message:'Notifications Page',
      notifications: -> Notifications.find(),
      invitations: ->
        CoLabs.formatInvitations Invitations.find().fetch()
  }
  
  @route 'inviteUsers', {
    path:'/inviteUsers'
    waitOn: ->
      Meteor.subscribe 'allInvitations'
    onBeforeAction: redirectIfNotVerified
    #data: -> Meteor.users.find().fetch()
  }