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
        Router.go '/notifications'
)

Template.notificationsLanding.helpers (
    isGeneral: ->
        general=Session.get('notificationsToShow')=="general"
        general
    isInvitations: ->
        invitations=Session.get('notificationsToShow')=="invitations"
        invitations
        
)