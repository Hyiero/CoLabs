Template.profileEdit.events
  'submit form': (e) ->
    e.preventDefault()
    longTagString = e.target.tagTextBox.value
    allTags = longTagString.trim().split ' '

    if allTags.length is 1 and allTags[0] is ''
      allTags = []

    Meteor.call 'updateUser', {
      email: e.target.emailTextBox.value
      avatar: e.target.avatarPathTextBox.value or @identiconHex
      firstName: e.target.firstNameTextBox.value
      lastName: e.target.lastNameTextBox.value
      description: e.target.descriptionTextBox.value
      age: e.target.ageTextBox.value
      tags: allTags
      identiconHex: Session.get 'identiconHex' or @identiconHex
    }, (err, res) ->
      if err?
        toast.danger 'Error!',
          err.reason or 'Email address is already taken.'
        console.error err
      else toast.success 'Success!',
        "You're profile was updated."

getCurrentTags = -> Session.get 'tags'
getConcatTags = -> getCurrentTags()?.join ' '

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
  concatTags:-> getConcatTags()
  currentTags:-> getCurrentTags()
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
      Meteor.call 'removeUser', (err, res) ->
        if err? then toast.error err?.message
        Modal.hide 'removeUserModal'
  cancelRemoveButton: -> Render.button
    text: 'Get me out of here!'
    icon: 'child'
    type: 'info'
    dataDismiss: 'modal'

    
Template.tagButton.events
  'click': (e) ->
    e.preventDefault()
    tags = getCurrentTags()
    index = tags.indexOf e.target.value
    if index > -1
      tags.splice index, 1
    Session.set 'tags', tags
