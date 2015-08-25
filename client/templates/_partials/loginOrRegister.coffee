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
    event.preventDefault()
    
    if isLoginChecked
      username = event.target.username.value
      password = event.target.password.value
      
      Meteor.loginWithPassword username, password, (err) ->
        if not err then Modal.hide 'loginOrRegisterModal'
        else console.warn 'TODO: Login failed message toast'
      
      
    else
      username = event.target.username.value
      email = event.target.email.value
      password = event.target.password.value
      verifyPassword = event.target.verifyPassword.value
      
      if password isnt verifyPassword
        console.warn 'TODO: Need to check password'
      
      Accounts.createUser {
        username: username,
        email: email,
        password: password
      }, (err) ->
        #if err and err.reason is 'Email already exists.' then ...
        if err isnt undefined then alert err.reason #TODO: Use input-box or other ui error
        else Modal.hide 'loginOrRegisterModal'

Template.signOutButton.events
  'click': (event) ->
    Meteor.logout()