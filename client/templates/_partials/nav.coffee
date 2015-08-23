Template.loginButton.events
  'click': ->
    authService = this.toString()
    authService = authService[0].toUpperCase() + authService.slice(1)
    console.log authService
    Meteor["loginWith#{authService}"]()


Template.navLinks.rendered = ->
  routeName = Router.current().route.getName();
  document.getElementById(routeName).classList.add('active')

Template.navLinks.helpers(
  verifiedUser: ->
    if Meteor.users.find({'_id': Meteor.userId(),'emails.verified' : true}).count() != 0
      true
    else
      false
)

Template.verifiedUserNavLinks.created = ->
  if Meteor.user()?
    console.log "Are you logged in?"
    $('#projectsLanding').addClass('hidden')

Template.profileNavLink.helpers(
  username: ->
    Meteor.user().username
)