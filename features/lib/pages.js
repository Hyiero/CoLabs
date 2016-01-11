
var app = require('./app.js')
var components = require('./components.js')
var Button = components.Button
var Link = components.Link
var Input = components.Input
var View = components.View


var toasts = function (index) {
  client.getText('.toast')
}

var splash = {
  
  buttons: {
    searchProjects: new Button('#searchProjects'),
    
    searchUsers: new Button('#searchUsers'),
    
    // ...
  }
  
}

var profile = {

  get url() {
    return app.baseUrl + '/profile/' + this.username || ''
  },
  
  buttons: {
    emailDisplay: new Button('#email'),

    firstNameDisplay: new Button('#firstName'),

    // ...
  }

}

module.exports = {
  splash: splash,
  profile: profile
}
