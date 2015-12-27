Template.profileEdit.events
  'submit form': (e) ->
    e.preventDefault()
    longSkillString = e.target.skillTextBox.value
    longInterestString = e.target.interestTextBox.value
    allSkills = longSkillString.trim().split ' '
    allInterests = longInterestString.trim().split ' '

    if allSkills.length is 1 and allSkills[0] is '' then allSkills = []
    if allInterests.length is 1 and allInterests[0] is '' then allInterests = []

    Meteor.call 'updateUser', {
      email: e.target.emailTextBox.value
      avatar: e.target.avatarPathTextBox.value or @identiconHex
      firstName: e.target.firstNameTextBox.value
      lastName: e.target.lastNameTextBox.value
      description: e.target.descriptionTextBox.value
      age: e.target.ageTextBox.value
      skills: allSkills
      interests: allInterests
      identiconHex: Session.get 'identiconHex' or @identiconHex
    }, (err, res) ->
      if err?
        toast.danger 'Error!',
          err.reason or 'Email address is already taken.'
        console.error err
      else toast.success 'Success!',
        "Your profile was updated."

getCurrentSkills = -> Session.get 'skills'
getCurrentInterests = -> Session.get 'interests'
getConcatSkills = -> getCurrentSkills()?.join ' '
getConcatInterests = -> getCurrentInterests()?.join ' '

Template.profileEdit.helpers
  previewIdenticonButton: -> Render.button
    text: 'Preview Identicon'
    icon: 'random'
    type: 'info'
    class: 'form-control'
    onclick: ->
      hash = CoLabs.encodeAsHexMd5 Meteor.user()?.name + Date.now()
      Session.set 'identiconHex', hash
  resetAvatarButton: -> Render.button
    text: 'Reset Avatar'
    icon: 'refresh'
    class: 'form-control'
    onclick: -> Session.set 'identiconHex', null
  buttonBack: -> Render.buttonCancel
    class: 'js-btn-back'
    icon: 'hand-o-left'
    text: 'Back'
    onclick: -> Router.go '/profile'
  buttonSave: -> Render.buttonSave
    id: 'submitProfileEditButton'
    text: 'Save Changes'
  buttonDelete: -> Render.buttonDelete
    text: 'Delete Account'
    class: 'delete-account'
    onclick: -> Modal.show 'removeUserModal'
  user: -> Meteor.user()
  email: ->
    user = Meteor.user()
    if user?.emails?.length > 0

      # Gets first verified email
      emails = user.emails.filter (e) -> e.verified
      if emails.length > 0 then emails[0].address
      
      # Gets first email
      else user.emails[0].address
  concatSkills:-> getConcatSkills()
  concatInterests:-> getConcatInterests()
  currentSkills:-> getCurrentSkills()
  currentInterests:-> getCurrentInterests()
  identiconHex: -> Session.get 'identiconHex' or @identiconHex
  avatar: -> @avatar or Session.get 'identiconHex' or @identiconHex


Template.removeUserModal.helpers
  buttonClose: -> Render.buttonClose
    class: 'pull-right'
    dataDismiss: 'modal'
  removeUserButton: -> Render.buttonDelete
    icon: 'bomb'
    text: 'Yes, burn it!'
    onclick: ->
      Meteor.call 'removeSelf', (err, res) ->
        if err? then toast.error err?.message
        Modal.hide 'removeUserModal'
  cancelRemoveButton: -> Render.button
    text: 'Get me out of here!'
    icon: 'child'
    type: 'info'
    dataDismiss: 'modal'
