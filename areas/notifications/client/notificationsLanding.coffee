sendTo window,
  sendOneNotification: (type, date, sender) ->
    console.log 'Sending one Notification:', { type, date, sender }
    # TODO: Use Meteor.userId on server side for security
    Meteor.call 'sendNotification', { type, date, sender }
  sendAcceptOrDecline: (data, isAccepted) ->
    { projectId, invitationId } = data
    # TODO: UserId
    Meteor.call 'addUserToProject', Meteor.userId(), projectId, (err, data) ->
      if err? then throw new Error err
      Meteor.call 'removeInvitation', invitationId
      sendOneNotification "Invitation #{
        if isAccepted then 'Accepted' else 'Declined'
      }", new Date, Meteor.userId()

Template.notifications.onCreated ->
  @subscribe 'allNotifications'

Template.notifications.helpers
  sendNotificationTestButton: -> Render.button # TODO REMOVE TEST BUTTON
    text: 'Send Test Notification'
    icon: 'send'
    onclick: -> sendOneNotification 'Test', new Date, Meteor.user()?._id
  showGeneralButton: -> Render.button
    icon: 'flag-o'
    text: 'General'
    type: 'info'
    onclick: -> Session.set 'notificationsToShow', 'general'
  showInvitationsButton: -> Render.button
    icon: 'user-plus'
    text: 'Invitations'
    type: 'success'
    onclick: -> Session.set 'notificationsToShow', 'invitations'
  acceptInvitationButton: -> Render.buttonSave
    icon: 'thumbs-o-up'
    text: 'Accept'
    dataContext: { projectId, invitationId }
    onclick: -> sendAcceptOrDecline @data('context'), true
  declineInvitationButton: -> Render.buttonDelete
    icon: 'thumbs-o-down'
    text: 'Decline'
    dataContext: { projectId, invitationId }
    onclick: -> sendAcceptOrDecline @data('context'), false
  isGeneral: -> (Session.get 'notificationsToShow') is 'general'
  isInvitations: -> (Session.get 'notificationsToShow') is 'invitations'
