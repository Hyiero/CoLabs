tagsWithStatus = (status)-> Tags.find(status: status).fetch()

Template.reviewFlagged.helpers
  flagged: -> tagsWithStatus 'flagged'

Template.reviewFlagged.events
  "click .reviewButton": (event)->
    $elem = $ event.currentTarget
    updateModel =
      tagId: $elem.parent().data['target']
      status: $elem.data['status']
    Meteor.call 'updateTag', updateModel

Template.acceptedTags.helpers
  accepted: -> tagsWithStatus 'accepted'

Template.blockedTags.helpers
  blocked: -> tagsWithStatus 'blocked'