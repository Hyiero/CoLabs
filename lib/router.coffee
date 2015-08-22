Router.map ->
  @route 'splashLanding',
    path: '/'
    data: ->
      message: 'Welcome to CoLabs'
  @route 'profileShow',
    path: '/profile'
    data: ->
      message: 'Profile page'
  @route 'search',
    path: '/search'
    data: ->
      message: 'Search page'
  @route 'adminLanding',
    path: '/admin'
    data: ->
      adminMessage: 'Admin page'
