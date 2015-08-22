Router.map ->
  @route 'splashLanding',
    path: '/'
    data: ->
      message: 'Welcome to CoLabs'
  @route 'profileShow',
    path: '/profile'
    data: ->
      message: 'Profile page'
      user:Users.GetTestUser()
  @route 'search',
    path: '/search'
    data: ->
      message: 'Search page'
  @route 'admin',
    path: '/admin'
    data: ->
      message: 'Admin page'


