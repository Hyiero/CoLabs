
var components = require('./components.js')
var Button = components.Button
var Link = components.Link

console.info(components)

var splash = {
  
  buttons: {
    searchProjects: new Button('#searchProjects'),
    
    searchUsers: new Button('#searchUsers'),
    
    // ...
  }
  
}

var profile = {
  
  emailDisplay: new Button('#email'),
  
  firstNameDisplay: new Button('#firstName'),
  
  // ...
  
}

exports = {
  splash: splash,
  profile: profile,
}