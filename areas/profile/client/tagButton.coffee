Template.tagButton.events(
  'click':(e)->
    e.preventDefault()
    tags=Session.get("tempTags")
    index=tags.indexOf(e.target.value)
    if index > -1
      tags.splice(index,1)
    Session.set("tempTags",tags)
)