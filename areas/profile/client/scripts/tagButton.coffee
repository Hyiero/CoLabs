Template.tagButton.events(
  'click':(e)->
    e.preventDefault()
    newInterests=Meteor.user().interests.remove(this.name)
    Session.set("tempInterests",newInterests)
)