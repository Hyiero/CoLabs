Template.profileEdit.events
  "submit form": (e) ->
    e.preventDefault()
    user = Meteor.user()
    id = user._id
    longTagString = e.target.tagTextBox.value
    allTags = longTagString.trim().split " "

    if allTags.length is 1 and allTags[0] is ""
      allTags = []

    Meteor.call "updateUser", {
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
        
  "click #regenButton": (e) ->
    e.preventDefault()
    user = Meteor.user()
    if user?
      id = user._id
      hash = CoLabs.encodeAsHexMd5 user.name + Date.now()
      Session.set 'identiconHex', hash

  "click #resetAvatar": (e) ->
    Session.set 'identiconHex', @avatar or @identiconHex
      
  "click .js-btn-back": (e) ->
    Router.go '/profile'
    
  "click .delete-account": (e) ->
    Modal.show "removeUserModal"
      
getConcatTags = -> getCurrentTags()?.join " "
getCurrentTags = -> Session.get "tempTags"

Template.profileEdit.helpers
  buttonBack: -> Render.buttonCancel {
    class: 'js-btn-back'
    icon: 'hand-o-left'
    text: 'Back'
  }
  buttonSave: -> Render.buttonSave {
    id: 'submitProfileEditButton'
    text: 'Save Changes'
  }
  buttonDelete: -> Render.buttonDelete {
    text: 'Delete Account'
    class: 'delete-account'
  }
  user: -> Meteor.user()
  email: ->
    user = Meteor.user()
    if user? and user.emails? and user.emails.length > 0
      
      # Gets first verified email
      emails = user.emails.filter (e) -> e.verified
      if emails.length > 0 then email = emails[0].address
      
      # Gets first email
      else email = user.emails[0].address
    
  concatTags:-> getConcatTags()
  currentTags:-> getCurrentTags()
  saveTagsToSession:-> Session.set "tempTags", Meteor.user()?.tags
  identiconHex: -> Session.get 'identiconHex' or @identiconHex
  avatar: -> @avatar or Session.get 'identiconHex' or @identiconHex
  
Template.removeUserModal.events
  "click #removeUserButton": (e) ->
    Meteor.call 'removeUser'
    Modal.hide 'removeUserModal'