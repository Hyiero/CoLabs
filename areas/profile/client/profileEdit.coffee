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
      avatar: e.target.avatarPathTextBox.value or this.identiconHex
      firstName: e.target.firstNameTextBox.value
      lastName: e.target.lastNameTextBox.value
      age: e.target.ageTextBox.value
      tags: allTags
      identiconHex: Session.get 'identiconHex' or this.identiconHex
    }, (err, res) ->
      if err? then toast.danger 'Error!',
        'Email address is already taken.'
      else toast.success 'Success!',
        "You're profile was updated."
        
  "click #regenButton": (e) ->
    e.preventDefault()
    user = Meteor.user()
    if user?
      id = user._id
      hash = CoLabs.encodeAsHexMd5 user.name + Date.now()
      Session.set 'identiconHex', hash
      
  "click .js-btn-back": (e) ->
    e.preventDefault()
    Router.go '/profile'
      
getConcatTags = -> getCurrentTags()?.join " "
getCurrentTags = -> Session.get "tempTags"

Template.profileEdit.helpers
  user: -> Meteor.user()
  email: ->
    user = Meteor.user()
    #console.log user
    ( ( user?.emails?.filter (e) -> e.verified )?.map (e) -> e.address )[0]
  concatTags:-> getConcatTags()
  currentTags:-> getCurrentTags()
  saveTagsToSession:-> Session.set("tempTags",Meteor.user()?.tags)
  identiconHex: -> Session.get 'identiconHex' or this.identiconHex
