Template.projectsLanding.helpers
  projects: Projects.find().fetch()

Template.projectForm.events
  'click #submitProject': (e) ->
    e.preventDefault()
    data = {
      name: $('#projectName').val(),
      description: $('#projectDescription').val()
    }
    Meteor.call 'createProject', data, (args...) ->
      console.log args

  'click button.edit': (e) ->
    Session.set 'editProject', true

Template.projectForm.helpers
  projectName: ->
    @projectName or ''
  projectDescription: ->
    @projectDescription or ''
  edit: -> Session.get 'editProject'