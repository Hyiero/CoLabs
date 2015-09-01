Router.map ->
  @route 'splashLanding',
    path: '/'
    data: ->
      message: 'Welcome to CoLabs'

  @route 'profileLanding',
    path: '/profile'
    onBeforeAction: () ->
      if Meteor.userId()?
        this.next()
      else
        Router.go('/')
    data: ->
      message: 'Profile page'
      user: Meteor.user()

  @route 'profileEdit',
    path:'/profile/edit'
    onBeforeAction: () ->
      if Meteor.userId()?
        this.next()
      else
        Router.go('/')
    data:->
      message: 'Profile edit page'
      user: Meteor.user()
      setSession:()->
        Session.set("tags",Meteor.user().tags)

  @route 'search',
    path: '/search/:type?'
    waitOn: ->
      if @params.type?
        switch @params.type
          when "users" then Meteor.subscribe('allUsers')
          when "projects" then Meteor.subscribe('allProjects')
      else
        Meteor.subscribe('allUsers')
        Meteor.subscribe('allProjects')

  @route 'adminLanding',
    path: '/admin'
    data: ->
      adminMessage: 'Admin page'

  @route 'projectsLanding',
    path: '/projects'
    waitOn: () ->
      Meteor.subscribe 'thisUser', Meteor.userId()
    onBeforeAction: () ->
      if Meteor.userId()? and Helpers.isVerifiedUser(Meteor.userId())
        this.next()
      else
        Router.go('/')
    data: ->
      if Meteor.user() then Meteor.subscribe 'myProjects', Meteor.userId()
      projects = Projects.find({users:Meteor.userId()})
      #if not projects then Session.set 'editProject', true
      debug:projects.count()
      message: 'Projects Page'
      projects: projects
      projectName: Session.get "projectName"
      projectDescription: Session.get "projectDescription"

  @route 'inboxLanding',
  	 path: '/inbox'
    onBeforeAction: () ->
       if Meteor.userId()?
         this.next()
       else
         Router.go('/')

  @route 'notificationsLanding',
    path: '/notifications'
    waitOn: () ->
        Meteor.subscribe 'userInvitations', Meteor.userId()
    onBeforeAction: () ->
      if Meteor.userId()?
        this.next()
      else
        Router.go('/')
    data: ->
      message:'Notifications Page',
      notifications: -> Notifications.find(),
      invitations: -> Helpers.GetFormattedInvitations(Invitations.find().fetch())

  @route 'inviteUsers',
    path:'/inviteUsers'
    waitOn: () ->
      Meteor.subscribe 'thisUser', Meteor.userId()
    onBeforeAction: () ->
      if Meteor.userId()? and Helpers.isVerifiedUser(Meteor.userId())
        this.next()
      else
        Router.go('/')
    data: () ->
        multipleSelection: 'true'
