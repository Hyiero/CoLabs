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

@CoLabs.isVerifiedUser = ()-> anyEmailVerified Meteor.user()

@CoLabs.isAdmin = ()-> Meteor.user().isAdmin?

@CoLabs.IsUserInvitedToProject = (user, project)->
  Invitations.findOne(user: user, project: project)?
        
@CoLabs.formatInvitations = (list)-> (buildInvitation inv for inv in list)

@CoLabs.encodeAsHexMd5 = (text)-> CryptoJS.MD5(text).toString()
