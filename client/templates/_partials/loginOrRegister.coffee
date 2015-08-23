Template.loginOrRegister.events
  'submit form': (event) ->
    event.preventDefault()
    $elem = $(event.currentTarget)
    login = $elem.find('#login-username-or-email').val()
    password = $elem.find('#login-password').val()
    Meteor.loginWithPassword login, password

  'click #forgot-password-link': (event) ->
    #Todo render forgot password form

  'click #signup-link': (event) ->
    $('.login-or-register').html ''
    form = UI.render Template.register
    UI.insert form, $('.login-or-register')[0]