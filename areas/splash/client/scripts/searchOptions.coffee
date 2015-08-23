Template.splashLanding.events
  "click .searchChoice": (event) ->
    type = event.target.attributes['value'].value
    Session.set "searchFilter", type
    Session.set "search", type
    Router.go('/search')