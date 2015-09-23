anyEmailVerified = (user)->
  ( user?.emails?.filter (e) -> e.verified )?.length > 0

buildInvitation = (inv)->
  proj = Projects.findOne inv.project
  {
    projectName: proj.name
    projectDescription: proj.description
    projectId: proj._id
    invitationId: inv._id
    date: inv.date
  }

@CoLabs.isVerifiedUser = (id)-> anyEmailVerified Meteor.users.findOne id

@CoLabs.isAdmin = (id)-> Meteor.users.findOne(id).isAdmin?

@CoLabs.IsUserInvitedToProject = (user,project)->
  Meteor.subscribe 'allInvitations'
  for inv in Invitations.find().fetch()
    if inv.project == project and inv.user == user then return "true"
  "false"
        
@CoLabs.formatInvitations = (list)-> (buildInvitation inv for inv in list)

@CoLabs.encodeAsHexMd5 = (text)-> CryptoJS.MD5(text).toString()
