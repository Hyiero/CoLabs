anyEmailVerified = (user) ->
  user? and user.emails? and
  	( user.emails.filter (e) -> e.verified ).length > 0

@CoLabs.isVerifiedUser = (id) ->
  anyEmailVerified Meteor.user()

@CoLabs.IsUserInvitedToProject = (userId,projectId) ->
  Meteor.subscribe 'allInvitations'
  console.log Invitations.find().fetch()
  for inv in Invitations
    console.log inv.user+","+userId+","+inv.project+","+projectId
    if inv.project == projectId and inv.user == userId then "true"
  "false"
        
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
