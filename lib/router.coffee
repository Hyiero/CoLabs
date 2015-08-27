Router.map ->
  @route 'splashLanding',
    path: '/'
    data: ->
      message: 'Welcome to CoLabs'
  @route 'profileLanding',
    path: '/profile'
    data: ->
      message: 'Profile page'
      user: Meteor.user()
  @route 'profileEdit',
    path:'/profile/edit'
    data:->
      message: 'Profile edit page'
      user: Meteor.user()
      setSession:()->
        Session.set("tags",Meteor.user().tags)
  @route 'search',
    path: '/search'
  @route 'adminLanding',
    path: '/admin'
    data: ->
      adminMessage: 'Admin page'
  @route 'projectsLanding',
    path: '/projects'
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

  @route 'notificationsLanding',
    path: '/notifications'
    data: ->
      message:'Notifications Page',
      notifications: -> Notifications.find()
