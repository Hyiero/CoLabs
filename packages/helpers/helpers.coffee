@Helpers = {
  isVerifiedUser: ->
    if Meteor.users.find({'_id': Meteor.userId(),'emails.verified' : true}).count() != 0
      true
    else
      false
}