Template.loginButton.events
  'click': ->
    authService = this.toString()
    authService = authService[0].toUpperCase() + authService.slice(1)
    console.log authService
    Meteor["loginWith#{authService}"]()

Template.navLinks.rendered = ->
  routeName = Router.current().route.getName();
  linkClicked = document.getElementById(routeName)

  if linkClicked? then linkClicked.classList.add('active') else console.log 'stop breaking shit'

Template.navLinks.helpers
  verifiedUser: ->
    if Meteor.users.find({'_id': Meteor.userId(),'emails.verified' : true}).count() != 0
      true
    else
      false
      #Helpers.isVerifiedUser() Add back in when not tired as fuck

Template.verifiedUserNavLinks.created = ->
  if Meteor.user()?
    $('#projectsLanding').addClass('hidden')

Template.profileNavLink.helpers(
  username: ->
    if Meteor.users.find({'_id' : Meteor.userId()})
      Meteor.user().username
)