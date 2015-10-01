Template.profileEdit.onCreated ->
  @subscribe 'allTags'
  Session.set 'identiconHex', this.identiconHex
  Session.set 'currentTags', (Tags.findOne(tag).value for tag in Meteor.user()?.tags)

tagNotBlocked = (value)->
  console.log value: value
  tag = Tags.findOne(value: value)
  console.log tag: tag
  if tag? then tag.status isnt 'blocked'
  else
    console.log "Add tag"
    Meteor.call 'addTag', value
    console.log tag: Tags.findOne(value: value)
    true

Template.profileEdit.events
  "submit form": (e) ->
    e.preventDefault()
    longTagString = e.target.tagTextBox.value
    allTags = longTagString.trim().split " "

    if allTags.length is 1 and allTags[0] is "" then allTags = []

    allTags = (Tags.findOne(value: value)._id for value in allTags when tagNotBlocked value)

    console.log allTags: allTags

    Meteor.call "updateUser", {
      email: e.target.emailTextBox.value
      avatar: e.target.avatarPathTextBox.value or this.identiconHex
      firstName: e.target.firstNameTextBox.value
      lastName: e.target.lastNameTextBox.value
      description: e.target.descriptionTextBox.value
      age: e.target.ageTextBox.value
      tags: allTags
      identiconHex: Session.get 'identiconHex' or this.identiconHex
    }, (err) ->
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
      hash = CoLabs.encodeAsHexMd5 user.name + Date.now()
      Session.set 'identiconHex', hash

  "click #resetAvatar": (e) ->
    Session.set 'identiconHex', this.avatar or this.identiconHex
      
  "click .js-btn-back": (e) ->
    Router.go '/profile'

getCurrentTags = -> Session.get 'currentTags'

Template.profileEdit.helpers
  user: -> Meteor.user()
  email: ->
    user = Meteor.user()
    if user? and user.emails? and user.emails.length > 0
      
      # Gets first verified email
      emails = user.emails.filter (e) -> e.verified
      if emails.length > 0 then email = emails[0].address
      
      # Gets first email
      else email = user.emails[0].address
    
  concatTags:-> getCurrentTags()?.join " "
  currentTags:-> getCurrentTags()
  identiconHex: -> Session.get 'identiconHex' or this.identiconHex
  avatar: -> this.avatar or Session.get 'identiconHex' or this.identiconHex

Template.tagButton.events
  'click':(e)->
    e.preventDefault()
    tags = (tag for tag in getCurrentTags() when tag isnt e.target.value)
    Session.set "currentTags", tags