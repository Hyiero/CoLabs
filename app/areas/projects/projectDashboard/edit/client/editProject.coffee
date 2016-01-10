getCurrentSkills = -> Session.get 'skills'
getCurrentInterests = -> Session.get 'interests'
getConcatSkills = -> getCurrentSkills()?.join ' '
getConcatInterests = -> getCurrentInterests()?.join ' '

Template.editProject.onCreated ->
  @subscribe 'oneProject', Router.current().params.id
  Session.set 'skills', Projects.findOne().skills
  Session.set 'interests', Projects.findOne().interests

Template.editProject.helpers
  buttonBack: -> Render.buttonCancel
    class: 'js-btn-back'
    icon: 'hand-o-left'
    text: 'Back'
    onclick: -> Router.go "/project/#{Router.current().params.id}/settings"
  buttonSave: -> Render.buttonSave
    id: 'submitProjectEditButton'
    text: 'Save Changes'
  project: -> Projects.findOne()
  concatSkills:-> getConcatSkills()
  concatInterests:-> getConcatInterests()
  currentSkills:-> getCurrentSkills()
  currentInterests:-> getCurrentInterests()

Template.editProject.events
  'submit form': (e) ->
    e.preventDefault()
    longSkillString = e.target.skillTextBox.value
    longInterestString = e.target.interestTextBox.value
    allSkills = longSkillString.trim().split ' '
    allInterests = longInterestString.trim().split ' '

    if allSkills.length is 1 and allSkills[0] is '' then allSkills = []
    if allInterests.length is 1 and allInterests[0] is '' then allInterests = []

    Meteor.call 'updateProject', {
      id: Router.current().params.id
      name: e.target.nameTextBox.value
      description: e.target.descriptionTextBox.value
      skills: allSkills
      interests: allInterests
    }, (err, res) ->
      unless err?
        toast.success 'Success!',
          "Your project was updated."
