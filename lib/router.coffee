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
        Session.set("tags",Meteor.user().interests)
  @route 'search',
    path: '/search'
  @route 'adminLanding',
    path: '/admin'
    data: ->
      adminMessage: 'Admin page'
  @route 'projectsLanding',
    path: '/projects'
    data: ->
      message: 'Projects Page'
