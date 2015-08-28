Template.profileEdit.events
  'submit form':(e) ->
    e.preventDefault()
    user = Meteor.user()
    if user
      id = user._id
      longTagString = e.target.tagTextBox.value
      allTags = longTagString.trim().split ' '

      if allTags.length is 1 and allTags[0] is ''
        allTags = []

    Meteor.call 'updateUser', id,
      email: e.target.emailTextBox.value
      avatar: e.target.avatarPathTextBox.value
      firstName: e.target.firstNameTextBox.value
      lastName: e.target.lastNameTextBox.value
      age: e.target.ageTextBox.value
      tags: allTags


getConcatTags = ->
  strings = ""
  for tag in getCurrentTags()
    strings = strings + ' ' + tag
  strings.substring 1, strings.length

getCurrentTags = -> Session.get 'tempTags'

Template.profileEdit.helpers
  concatTags:-> getConcatTags()
  currentTags:-> getCurrentTags()
  saveTagsToSession:-> Session.set("tempTags",Meteor.user().tags)
