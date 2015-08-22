Template.loginButton.events
  'click': ->
    Meteor["loginWith#{this}"]()


