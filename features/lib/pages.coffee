app = require './app.coffee'
components = require './components.coffee'
Button = components.Button
Link = components.Link
Input = components.Input
View = components.View


splash =
  buttons:
    searchProjects: new Button '#searchProjects'
    searchUsers: new Button '#searchUsers'

profile =
  url: ->
    app.baseUrl + '/profile'

  buttons:
    emailDisplay: new Button('#email')
    firstNameDisplay: new Button('#firstName')

module.exports =
  splash: splash
  profile: profile