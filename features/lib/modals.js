
var components = require('./components.js')
var Button = components.Button
var Input = components.Input

var loginOrRegister = {
  inputs: {
    loginOption: new Input('#loginRadioOption'),
    
    signupOption: new Input('#signupRadioOption'),
    
    username: new Input('#login-username'),
    
    email: new Input('#login-email'),
    
    password: new Input('#login-password'),
    
    verifyPassword: new Input('#login-verify-password')
  },
  
  buttons: {
    close: new Button('#closeLoginModal'),
    
    submit: new Button('#signinSubmit')
  }
}

module.exports = {
  loginOrRegister: loginOrRegister
}
