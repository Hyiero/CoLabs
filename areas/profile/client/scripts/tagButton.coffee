Template.tagButton.events(
  'click':(e)->
    e.preventDefault()
    interests=Session.get("tempInterests")
    index=interests.indexOf(e.target.value)
    if index > -1
      interests.splice(index,1)
    Session.set("tempInterests",interests)
)