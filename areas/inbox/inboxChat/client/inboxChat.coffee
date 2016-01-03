Template.chat.onCreated ->
  @subscribe 'messagesWith', Session.get 'contact'
  @subscribe 'oneUser', Session.get 'contact'

getPair = ->
  user: Meteor.userId()
  contact: Session.get 'contact'

Template.chat.helpers
  currentConversation: ->
    contact = Session.get 'contact'
    Meteor.call 'readMessages', contact
    conv = Messages.find().fetch()
    conv?.sort (a, b)-> a.timeStamp - b.timeStamp
  currentContactName: ->
    contactId = Session.get 'contact'
    contact = Meteor.users.findOne contactId
    contact?.username or 'Deleted User'
  userName: -> Meteor.user().username

Template.chat.events
  'click #submitMessage': ->
    pair = getPair()
    {user, contact} = pair
    messageModel =
      to: contact
      message: $('#messageContent').val()
    Meteor.call 'addContact', contact unless Messages.findOne(to: contact, from: user)?
    Meteor.call 'addMessage', messageModel
    $('#messageContent').val ''