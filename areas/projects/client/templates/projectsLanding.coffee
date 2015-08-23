Template.projectForm.events
  'click #submitProject': (e) ->
    e.preventDefault()
    console.log($('#projectName').val())
    console.log($('#projectDescription').val())