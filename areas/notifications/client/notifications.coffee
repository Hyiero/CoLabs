Template.notificationTypeSelectors.helpers
  isAll: -> not Router.current().params.type?
  isGeneral: -> Router.current().params.type? is 'general'
  isInvites: -> Router.current().params.type? is 'invites'

Template.notificationTypeSelectors.events
  'change .typeSelector': (event) ->
    $elem = $ event.currentTarget
    if $elem.is ':checked'
      val = $elem.val()
      if val != 'all' then Router.go 'notifications', type: val
      else Router.go 'notifications'

Template.notificationList.onCreated ->
  @subscribe 'myNotifications'

Template.notificationList.helpers
  acceptInvitationButton: -> Render.buttonSave
    icon: 'thumbs-o-up'
    text: 'Accept'
    class: 'pull-right'
    dataContext: { notificationId: @_id, isAccept: true }
    onclick: -> Meteor.call 'respondToInvite', @data('context')
  declineInvitationButton: -> Render.buttonDelete
    icon: 'thumbs-o-down'
    text: 'Decline'
    class: 'pull-right'
    dataContext: { notificationId: @_id }
    onclick: -> Meteor.call 'respondToInvite', @data('context')
  notifications: -> Notifications.find('data.status': 'none').fetch()
  isInvite: (type) -> type is 'invite'
