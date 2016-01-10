Helpers = {
  isVerifiedUser: ->
    if Meteor.users.find({'_id': Meteor.user()._id,'emails.verified' : true}).count() != 0
      true
    else
      false
}

sendTo = (context, fnsMap) =>
  context[name] = fn for name, fn of fnsMap