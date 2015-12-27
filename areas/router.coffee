Router.configure
  load: ->
    $('html, body').animate scrollTop: 0
    @next()
  layoutTemplate: 'layout'
  landingTemplate: 'splash'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'
  waitOn: -> Meteor.subscribe 'thisUser'


searchTypes = [
  'users'
  'projects'
]

notificationTypes = [
  'general'
  'invites'
]

isValidSearchType = (type) -> if type? then type in searchTypes

isValidNotificationType = (type) -> if type? then type in notificationTypes

isLoggedIn = -> CoLabs.isLoggedIn()

isVerified = -> CoLabs.isVerifiedUser()

isCoLabsAdmin = -> CoLabs.isAdmin()


redirectUnless = (ctor, perms) ->
  for perm in perms
    { func, args, fail } = perm
    unless func args
      Router.go fail
      break
  ctor.next()


Router.map ->
  @route 'splash',
    path: '/'
    layoutTemplate: ''


  @route 'search',
    path: '/search/:type?'
    onBeforeAction: -> redirectUnless @, [
      { func: isValidSearchType, args: @params.type, fail: '/search' }
    ]


  @route 'profile',
    path: '/profile'
    onBeforeAction: -> redirectUnless @, [
      { func: isLoggedIn, fail: '/' }
    ]
  
  @route 'profileEdit',
    path:'/profile/edit'
    onBeforeAction: -> redirectUnless @, [
      { func: isLoggedIn, fail: '/' }
    ]
    data: ->
      Session.set 'skills', Meteor.user().skills
      Session.set 'interests', Meteor.user().interests
  
  @route 'otherProfile',
    path: '/user/:username'
    # TODO: redirect if username not valid


  @route 'inbox',
    path: '/inbox'
    onBeforeAction: -> redirectUnless @, [
      { func: isLoggedIn, fail: '/' }
    ]

  @route 'inboxChat',
    path: '/inbox/:username'
    onBeforeAction: -> redirectUnless @, [
      { func: isLoggedIn, fail: '/' }
      # TODO: redirect if username not valid
    ]
    data: ->
      contact = Meteor.users.findOne(username: @params.username)._id
      Session.set 'contact', contact


  @route 'notifications',
    path: '/notifications/:type?'
    onBeforeAction: -> redirectUnless @, [
      { func: isLoggedIn, fail: '/' }
      { func: isValidNotificationType, args: @params.type, fail: '/notifications' }
    ]


  @route 'projects',
    path: '/projects'
    onBeforeAction: -> redirectUnless @, [
      { func: isVerified, fail: '/' }
    ]

  @route 'projectDashboard',
    path: '/project/:id'
    # TODO: redirect if id not valid

  @route 'projectSettings',
    path:'/project/:id/settings'
    # TODO: redirect if id not valid
    # TODO: redirect if not project admin

  @route 'editProject',
    path:'/project/:id/edit'
    # TODO: redirect if id not valid
    # TODO: redirect if not project admin

  @route 'inviteUsers',
    path:'/project/:id/invite'
    # TODO: redirect if id not valid
    # TODO: redirect if not project admin


  @route 'admin',
    path: '/admin'
    onBeforeAction: -> redirectUnless @, [
      { func: isCoLabsAdmin, fail: '/' }
    ]
    data: -> Session.set 'logEnabled', Logger.isEnabled

  @route 'adminPower',
    path: '/admin/power'
    onBeforeAction: -> redirectUnless @, [
      { func: isCoLabsAdmin, fail: '/' }
    ]
