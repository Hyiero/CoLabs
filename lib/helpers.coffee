anyEmailVerified = (user) ->
  ( user?.emails?.filter (e) -> e.verified )?.length > 0

@CoLabs.isVerifiedUser = (id) ->
  user=Meteor.users.findOne(_id:id)
  anyEmailVerified user

@CoLabs.IsUserInvitedToProject = (user,project) ->
  Meteor.subscribe 'allInvitations'
  for inv in Invitations.find().fetch()
    if inv.project == project and inv.user == user then return "true"
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

@CoLabs.encodeAsHexMd5 = (text) ->
  CryptoJS.MD5(text).toString()
