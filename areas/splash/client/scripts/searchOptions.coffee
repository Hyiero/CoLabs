Template.splashLanding.events
  "click #searchUsers": (event) ->
    Session.set "searchFilter", "user"
    Session.set "search", "user"
  "click #searchProjects": (event) ->
    Session.set "searchFilter", "project"
    Session.set "search", "project"