Template.signInButton.events
  'click': (event) ->
    Modal.show('loginOrRegisterModal')

Template.loginOrRegisterModal.events
  'click #loginRadioOption': (event) ->
    $('#login-email').addClass('hidden')
    $('#login-verify-password').addClass('hidden')
    $('#signinSubmit').val('Log In')
  'click #signupRadioOption': (event) ->
    $('#login-email').removeClass('hidden')
    $('#login-verify-password').removeClass('hidden')
    $('#signinSubmit').val('Sign Up')
  'submit form': (event) ->
    isLoginChecked = document.getElementById('loginRadioOption').checked
    if isLoginChecked
      event.preventDefault()
      username = event.target.username.value
      password = event.target.password.value
      Meteor.loginWithPassword(username,password)
      Modal.hide("loginOrRegisterModal")
    else
      username = event.target.username.value;
      email = event.target.email.value;
      password = event.target.password.value;
      verifyPassword = event.target.verifyPassword.value;
      Accounts.createUser({
        username: username,
        email: email,
        password: password
      })

Template.signOutButton.events
  'click': (event) ->
    Meteor.logout()