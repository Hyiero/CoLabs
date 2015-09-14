Template.inviteUsersButtons.events 
  "click #inviteUsersToProject": ->
    $('.checkbox').each (val, ind) ->
      $box = $ val
      if $box.data 'is-enabled'
        userId = $box.data 'id'
        Meteor.call "inviteUserToProject",
          userId, Session.get "selectedProjectId"