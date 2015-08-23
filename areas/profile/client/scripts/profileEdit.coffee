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

      Meteor.users.update(
        {_id: id},
        {$set:
          {
            avatar: e.target.avatarPathTextBox.value
            firstName: e.target.firstNameTextBox.value
            lastName: e.target.lastNameTextBox.value
            age: e.target.ageTextBox.value
            interests: allTags
          }
        }
      )
    else console.warn 'No user in session.'

getConcatTags=()->
  strings=""
  for tag in getCurrentInterests()
    strings=strings+" "+tag
  strings.substring(1,strings.length)

getCurrentInterests=()->
    Session.get("tempInterests")

Template.profileEdit.helpers
  concatTags:()->
    getConcatTags()

  currentInterests:()->
    getCurrentInterests()

  saveInterestsToSession:()->
    Session.set("tempInterests",Meteor.user().interests)

