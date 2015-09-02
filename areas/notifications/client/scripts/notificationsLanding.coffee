Meteor.subscribe('allNotifications')

@SendOneNotification=(type,date,sender)->
  console.log(type+","+date+","+sender)
  Meteor.call('sendNotification',
    {
      type:type,
      date:date,
      sender:sender
    }
  )

Template.notificationsLanding.events (
    'click #showGeneralNotificationsButton': (e) ->
        Session.set 'notificationsToShow','general'
        
    
    'click #showInvitationsButton': (e)->
        Session.set 'notificationsToShow','invitations'
        
    'click #acceptInvitationButton': (e)->
        projectId=e.currentTarget.attributes["projectId"].value
        invId=e.currentTarget.attributes["invitationId"].value
        Meteor.call 'addUserToProject',Meteor.userId(),projectId, (data)->
            if data??
                Meteor.call 'removeInvitation',invId
                SendOneNotification "Invitation Accepted",new Date().toLocaleString(),
                                    Meteor.userId()
                    
     'click #declineInvitationButton': (e) -> 
         invId=e.currentTarget.attributes["invitationId"].value
         Meteor.call 'removeInvitation', invId        
         SendOneNotification "Invitation Declined",new Date().toLocaleString(),
                    Meteor.userId()
            
)

Template.notificationsLanding.helpers (
    isGeneral: ->
        general=Session.get('notificationsToShow')=="general"
        general
    isInvitations: ->
        invitations=Session.get('notificationsToShow')=="invitations"
        invitations
        
)