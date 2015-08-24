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
      if Meteor.user() then Meteor.subscribe 'myProjects', Meteor.user

      projects = Projects.find().fetch()
      if not projects then Session.set 'editProject', true

      message: 'Projects Page',
      projects: projects

  @route 'inboxLanding',
  	 path: '/inbox'

  @route 'notificationsLanding',
    path: '/notifications'
    data: ->
    message:'Notifications Page',
    notifications:()->
      Notifications.find()