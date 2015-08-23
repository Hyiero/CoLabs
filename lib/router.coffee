Router.map ->
  @route 'splashLanding',
    path: '/'
    data: ->
      message: 'Welcome to CoLabs'
  @route 'profileLanding',
    path: '/profile'
    data: ->
      message: 'Profile page'
      user:Meteor.user()
  @route 'search',
    path: '/search'
    data: ->
      message: 'Search page'
  @route 'adminLanding',
    path: '/admin'
    data: ->
      adminMessage: 'Admin page'


