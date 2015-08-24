@Helpers = {
  isVerifiedUser: (id)->
      AnyEmailVerified(Meteor.users.findOne({_id:id}))
}

AnyEmailVerified=(user) ->
  if user==null or user==undefined
    return false
  for email in user.emails
    if email.verified
      return true
  return false


OldMethod= () ->
  if Meteor.users.find({'_id': Meteor.user()._id,'emails.verified' : true}).count() != 0
   true
  else
   false
