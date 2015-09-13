anyEmailVerified = (user) ->
  user? and user.emails? and
  	( user.emails.filter (e) -> e.verified ).length > 0

@CoLabs.isVerifiedUser = (id) ->
  anyEmailVerified Meteor.user()
        
@CoLabs.formatInvitations = (list) ->
  newList = []
  for inv in list
    proj = Projects.findOne _id: inv.project
      
    newList.push
      projectName: proj.name
      projectDescription: proj.description
      projectId: proj._id
      invitationId: inv._id
      date: inv.date
    
  newList
