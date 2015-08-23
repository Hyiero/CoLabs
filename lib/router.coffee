Router.map ->
  @route 'splashLanding',
    path: '/'
    data: ->
      message: 'Welcome to CoLabs'
  @route 'profileLanding',
    path: '/profile'
    data: ->
      message: 'Profile page'
      user:Users.GetUserByName(Session.get(Constants.sessionLoggedInUserKey))
      log:Users.GetUserByName(Session.get(Constants.sessionLoggedInUserKey))
  @route 'search',
    path: '/search'
    data: ->
      message: 'Search page'
  @route 'adminLanding',
    path: '/admin'
    data: ->
      adminMessage: 'Admin page'


