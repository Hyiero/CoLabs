@Helpers = {
  isVerifiedUser: (id)->
      AnyEmailVerified(Meteor.users.findOne({_id:id}))
}

AnyEmailVerified=(user) ->
  for email in user.emails
    if email.verified
      true
  false


OldMethod= () ->
  if Meteor.users.find({'_id': Meteor.user()._id,'emails.verified' : true}).count() != 0
   true
  else
   false
