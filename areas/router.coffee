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
      message: 'Profile edit page'
      user: Meteor.user()
      setSession:()->
        Session.set("tags",Meteor.user().tags)
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
    onBeforeAction: ->
      # TODO: Redirect if not admin
      console.warn 'TODO: Redirect if not admin'
      this.next()
  }
  
  @route 'projects', {
    path: '/projects'
    onBeforeAction: redirectIfNotVerified
    data: ->
      projects = Projects.find users:Meteor.userId()
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
    waitOn: ->  Meteor.subscribe 'thisUser', Meteor.userId()
    onBeforeAction: redirectIfNotVerified
    data: -> multipleSelection: 'true'
  }