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
    'http://localhost:3000/profile'

  buttons:
    emailDisplay: new Button '#email'
    firstNameDisplay: new Button '#firstName'

user =
  url: (username) ->
    'http://localhost:3000/user/' + username

  buttons:
    messageUser: new Button '#messageUser'
    inviteToProject: new Button '#inviteToProject'

inbox =
  url: ->
    'http://localhost:3000/inbox'

inboxChat =
  url: (username) ->
    'http://localhost:3000/inbox/' + username

  inputs:
    chat: new Input '#messageContent'

  buttons:
    submit: new Button '#submitMessage'

module.exports =
  splash: splash
  profile: profile
  user: user
  inbox: inbox
  inboxChat: inboxChat
