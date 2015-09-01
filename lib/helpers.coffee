@Helpers = {
  isVerifiedUser: (id)->
      AnyEmailVerified(Meteor.users.findOne({_id:id}))
        
  GetFormattedInvitations:(list) ->
    Meteor.subscribe 'allProjects'
    console.log Projects.find().fetch()
    newList=[]
    for inv in list
        project=Projects.findOne({_id:inv.project})        
        newList.push({
            projectName:project.name
            date:inv.date
            projectDescription:project.description
            })
        console.log newList
    return newList        
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
