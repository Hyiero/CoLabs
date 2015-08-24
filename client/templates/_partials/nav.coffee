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
  else console.log 'Nav link has incorrect id (id does not match route name)'

Template.navLinks.helpers
  verifiedUser: ->
    Helpers.isVerifiedUser(Meteor.userId())
  currentUser: ->
    Helpers.isVerifiedUser(Meteor.userId())#TODO: Don't know how to verify if current user (Session variable maybe?)

      #Helpers.isVerifiedUser() Add back in when not tired as fuck

Template.verifiedUserNavLinks.created = ->
  if !Meteor.user()?
    $('#projectsLanding').addClass('hidden')

Template.profileNavLink.helpers(
  username: ->
    if Meteor.users.find({'_id' : Meteor.user()._id})
      Meteor.user().username
)