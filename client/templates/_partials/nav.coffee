Template.loginButton.events
  'click': ->
    authService = this.toString()
    authService = authService[0].toUpperCase() + authService.slice(1)
    console.log authService
    Meteor["loginWith#{authService}"]()


#Template.navLinks.rendered = ->
#  routeName = Router.current().route.getName();
#  document.getElementById(routeName).classList.add('active')
