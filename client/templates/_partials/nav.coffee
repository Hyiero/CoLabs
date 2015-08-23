Template.loginButton.events
  'click': ->
    authService = this.toString()
    authService = authService[0].toUpperCase() + authService.slice(1)
    console.log authService
    Meteor["loginWith#{authService}"]()

Template.navLinks.rendered = ->
  routeName = Router.current().route.getName();
  linkClicked = document.getElementById(routeName)

  if linkClicked? then linkClicked.classList.add('active')
  else console.log 'stop breaking shit, Juan'

Template.navLinks.helpers
  verifiedUser: ->
    if Meteor.user()?
      id=Meteor.user()._id
    else
      id=""
    if Meteor.users.find({'_id':id ,'emails.verified' : true}).count() != 0
      true
    else
      false
      #Helpers.isVerifiedUser() Add back in when not tired as fuck

Template.verifiedUserNavLinks.created = ->
  if Meteor.user()?
    $('#projectsLanding').addClass('hidden')

Template.profileNavLink.helpers(
  username: ->
    if Meteor.users.find({'_id' : Meteor.user()._id})
      Meteor.user().username
)