Router.configure
  load: ->
    $('html, body').animate scrollTop: 0
    this.next()
  landingTemplate: "splash"
  loadingTemplate: "loading"
  notFoundTemplate: "notFound"
  #waitOn: -> Meteor.subscribe('recordSetThatYouNeedNoMatterWhat')

redirectIfNoUser = ->
  if Meteor.userId()? then this.next()
  else Router.go('/')

redirectIfNotVerified = ->
  if Meteor.userId()? and CoLabs.isVerifiedUser Meteor.userId()
    this.next()
  else Router.go('/')

redirectIfNotAdmin = ->
  if Meteor.userId()? and CoLabs.isAdmin Meteor.userId()
    this.next()
  else Router.go '/'

Router.map ->
  @route 'splash', {
    path: '/'
  }

  @route 'profile', {
    path: '/profile'
    onBeforeAction: redirectIfNoUser
    data: -> user: Meteor.user()
  }
  
  @route 'profileEdit', {
    path:'/profile/edit'
    onBeforeAction: redirectIfNoUser
    data:->
      user: Meteor.user()
      setSession:->
        Session.set "tags", Meteor.user().tags
  }
  
  @route 'otherProfile', {
    path: '/:username/profile'
    data:->
      username = this.params.username
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
    waitOn: () -> [
      (Meteor.subscribe 'thisUser', Meteor.user()._id),
      (Meteor.subscribe 'myProjects', Meteor.user()._id)
    ]
    onBeforeAction: redirectIfNotVerified
    data: ->
      projects = Projects.find users:Meteor.user()._id
      # if not projects then Session.set 'editProject', true
      debug: projects.count()
      message: "Projects Page"
      projects: projects
      projectName: Session.get "projectName"
      projectDescription: Session.get "projectDescription"
  }

  @route 'inbox', {
    path: '/inbox'
    onBeforeAction: redirectIfNoUser
  }
  
  @route 'notifications', {
    path: '/notifications'
    waitOn: ->
      Meteor.subscribe 'userInvitations', Meteor.userId()
      Meteor.subscribe 'allProjects'
    onBeforeAction: redirectIfNoUser
    data: ->
      message:'Notifications Page',
      notifications: -> Notifications.find(),
      invitations: ->
        CoLabs.formatInvitations Invitations.find().fetch()
  }
  
  @route 'inviteUsers', {
    path:'/inviteUsers'
    waitOn: ->  [
      (Meteor.subscribe 'thisUser', Meteor.userId()),
      (Meteor.subscribe 'allInvitations' )
      ]
    onBeforeAction: redirectIfNotVerified
    #data: -> Meteor.users.find().fetch()
  }