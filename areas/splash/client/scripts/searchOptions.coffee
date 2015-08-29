Template.splashLanding.events
  "click .searchChoice": (event) ->
    type = event.target.attributes['value'].value
    Session.set "typeSearch", type
    Session.set "tagSearch", ""
    Session.set "nameSearch", ""
    Router.go('search', {type: type})