Template.otherProfile.onCreated ->
    @subscribe 'thisUserByName', @params.username

Template.otherProfile.helpers
  firstEmail: ->
    email = @emails?[0]
    if email then email.address else ''
  firstVerifiedEmail: ->
    email = (@emails?.filter (e) -> e.verified)?[0]
    if email then email.address else ''
  isLoggedIn: -> Meteor.user()?
  isVerifiedUser:-> CoLabs.isVerifiedUser()
  hasEmailSaved:-> @emails?.length > 0
  hasVerifiedEmail:-> (@emails[0]?.filter (e) -> e.verified).length > 0
  interests:-> @tags?

Template.otherProfile.events
  'click #messageContact': (event) ->
    username = $(event.currentTarget).data 'username'
    Router.go "/inbox/#{username}"