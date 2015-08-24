Template.projectsLanding.helpers
  projects: Projects.find().fetch()

Template.project.helpers
  users: ->
    Users.find(
      _id: { $in: @users }
    )

Template.projectForm.events
  'click #submitProject': (e) ->
    e.preventDefault()
    data = {
      name: $('#projectName').target.val(),
      description: $('#projectDescription').target.val()
    }
    Meteor.call 'createProject', data, (err, res) ->
      if err console.error err
      else Session.set 'editProject', false

  'click button.edit': (e) ->
    Session.set 'editProject', true

Template.projectForm.helpers
  projectName: ->
    @projectName or ''
  projectDescription: ->
    @projectDescription or ''
  edit: -> Session.get 'editProject'