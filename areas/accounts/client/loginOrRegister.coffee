Template.signInButton.events
  "click": (event) ->
    Modal.show "loginOrRegisterModal"

Template.loginOrRegisterModal.helpers
  buttonClose: -> Render.buttonClose
    class: 'pull-right'
    'data-dismiss': 'modal'

Template.loginOrRegisterModal.events
  "click #loginRadioOption": (event) ->
    $("#login-email").addClass("hidden")
    $("#login-verify-password").addClass("hidden")
    $("#signinSubmit").val("Log In")
  "click #signupRadioOption": (event) ->
    $("#login-email").removeClass("hidden")
    $("#login-verify-password").removeClass("hidden")
    $("#signinSubmit").val("Sign Up")
    
  "submit form": (event) ->
    isLoginChecked = document.getElementById("loginRadioOption").checked
    event.preventDefault()

    if isLoginChecked
      username = event.target.username.value
      password = event.target.password.value
      
      Meteor.loginWithPassword username, password, (err) ->
        if not err then Modal.hide "loginOrRegisterModal"
        else toast.warning "<i class=\"fa fa-warning\" /> Warning!",
          "Username or Password is invalid."
      
    else
      username = event.target.username.value
      email = event.target.email.value
      password = event.target.password.value
      verifyPassword = event.target.verifyPassword.value
        
      Modal.allowMultiple = true
        
      if password isnt verifyPassword
        toast.danger "Passwords Don't Match",
          "Please make sure your password fields match."
      else
        Accounts.createUser {
          username: username,
          email: email,
          password: password
        }, (err) ->
          #TODO if err and err.reason is "Email already exists." then ...
          if err? then toast.danger "Error!", err.reason
          else
            Modal.allowMultiple = true
            Modal.hide "loginOrRegisterModal"
            if email isnt ""
              toast.success "Verification Email Sent",
                "Please check your email to verify your registration.
                Until you verify, you will not have the ability to create or participate in projects.",
                10000
            else
              toast.warning "You Cannot Verify Without An Email Address",
               "Please add an email address on your profile page in order to send the verification email.
                Without verifying, you will not have the ability to create or participate in projects.",
                10000

Template.signOutButton.events
  "click": ->
    Session.keys = {}
    Meteor.logout()
