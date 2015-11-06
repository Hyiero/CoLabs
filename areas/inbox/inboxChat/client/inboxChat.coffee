getPair = ->
  user: Meteor.userId()
  contact: Router.current().params.id

Template.chat.helpers
  currentConversation: ->
    contact = Router.current().params.id
    Meteor.call 'readMessages', contact
    conv = Messages.find().fetch()
    conv?.sort (a, b)-> a.timeStamp - b.timeStamp
  currentContactName: ->
    contactId = Router.current().params.id
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
      timeStamp: new Date()
    Meteor.call 'addContact', contact unless Messages.findOne(to: contact, from: user)?
    Meteor.call 'addMessage', messageModel
    $('#messageContent').val ''