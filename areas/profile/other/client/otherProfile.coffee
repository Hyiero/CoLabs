Template.otherProfile.onCreated ->
    @subscribe 'thisUserByName', this.params.username

Template.otherProfile.helpers
  firstEmail: ->
    email = this.emails?[0]
    if email then email.address else ''
  firstVerifiedEmail: ->
    email = (this.emails?.filter (e) -> e.verified)?[0]
    if email then email.address else ''
  isVerifiedUser:-> CoLabs.isVerifiedUser Meteor.userId()
  hasEmailSaved:-> this.emails?.length > 0
  hasVerifiedEmail:-> (this.emails[0]?.filter (e) -> e.verified).length > 0
  interests:-> this.tags?
