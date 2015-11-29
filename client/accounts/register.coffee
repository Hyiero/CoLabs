Template.register.events
  'form submit': (event) ->
    event.preventDefault()
    $elem = $(event.currentTarget)

    #Logger.enable()
    console.info
      user: $elem.find('#login-username').val()
      email: $elem.find('#login-email').val()
      password: $elem.find('#login-password').val()

    Accounts.createUser
      #user: $elem.find('#login-username').val()
      email: $elem.find('#login-email').val()
      password: $elem.find('#login-password').val()