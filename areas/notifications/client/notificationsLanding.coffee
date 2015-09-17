Meteor.subscribe "allNotifications"

@SendOneNotification=(type,date,sender)->
  console.log "Sending one Notification:" + type+","+date+","+sender
  Meteor.call "sendNotification",
    type:type
    date:date
    sender:sender

Template.notifications.events
  "click #showGeneralNotificationsButton": (e) ->
    Session.set "notificationsToShow","general"
    
  "click #showInvitationsButton": (e)->
    Session.set "notificationsToShow","invitations"
    
  "click #showMessagesButton": (e)->
    Session.set "notificationsToShow","messages"
        
  "click #acceptInvitationButton": (e)->
    projectId=e.currentTarget.attributes["projectId"].value
    invId=e.currentTarget.attributes["invitationId"].value
    Meteor.call "addUserToProject",Meteor.userId(),projectId, (err,data)->
      console.log data
      if data?
        Meteor.call "removeInvitation",invId
        SendOneNotification "Invitation Accepted",new Date().toLocaleString(),
          Meteor.userId()
                    
  "click #declineInvitationButton": (e) -> 
    invId=e.currentTarget.attributes["invitationId"].value
    Meteor.call "removeInvitation", invId        
    SendOneNotification "Invitation Declined",new Date().toLocaleString(),
      Meteor.userId()

Template.notifications.helpers
  notifications: ->
    notifications = Notifications.find({ type: Session.get("notificationsToShow") }).fetch()
  isGeneral: ->
    general = Session.get("notificationsToShow") == "general"
  isInvitations: ->
    invitations = Session.get("notificationsToShow") == "invitations"
  isMessages: ->
    messages = Session.get("notificationsToShow") == "messages"
