Template.splashLanding.events
  "click #searchUsers": (event) ->
    Session.set "searchFilter", "users"
    Session.set "search", "users"
  "click #searchProjects": (event) ->
    Session.set "searchFilter", "projects"
    Session.set "search", "projects"