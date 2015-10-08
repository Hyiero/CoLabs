Meteor.subscribe "allMessages"

userExists = (id)-> Meteor.users.findOne(id)?

getPair = ->
  user: Meteor.userId()
  contact: Session.get "currentContact"

splitTimeStamp = (timeStamp)->
  timeStamp = new Date timeStamp unless timeStamp.getDate?
  date: timeStamp.toLocaleDateString()
  time: timeStamp.toLocaleTimeString()

clean = (timeStamp)->
  today = (new Date()).toLocaleDateString()
  {date, time} = splitTimeStamp timeStamp
  if date is today then "Today, #{time}" else "#{date}, #{time}"

inbound = (id)-> Meteor.userId() is Messages.findOne(id).to

favorite = (id)->
  contacts = Meteor.user().contacts
  for contact in contacts
    return contact.favorite if id is contact.contact
  false

UI.registerHelper "nameOf", (id)-> Meteor.users.findOne(id).name

UI.registerHelper "timeOf", (id)-> clean Messages.findOne(id).timeStamp

UI.registerHelper "preview", (id)->
  message = Messages.findOne(id).message
  message = message.slice(0, 50) + "..." unless message.length < 50
  message

UI.registerHelper "favorite", (id)-> favorite id

UI.registerHelper "inbound", (id)-> inbound id

UI.registerHelper "unread", (id)-> not Messages.findOne(id).read

UI.registerHelper "cleanup", (timeStamp)-> clean timeStamp

UI.registerHelper "contactExists", (id)-> userExists id

UI.registerHelper "contactNameExists", (name)-> userExists Meteor.users.findOne(username:name)._id

Template.chat.helpers
  contactSelected: -> Session.get("currentContact")?
  currentConversation: ->
    pair = getPair()
    {user, contact} = pair
    Meteor.call "readMessages", pair
    conv = Messages.messagesBetween user, contact
    conv.sort (a, b)-> a.timeStamp - b.timeStamp
  currentContactName: ->
    contactId = Session.get "currentContact"
    contact = Meteor.users.findOne contactId
    contact?.username or "Deleted User"
  userName: -> Meteor.user().username

Template.chat.events
  "click #submitMessage": ->
    pair = getPair()
    {user, contact} = pair
    messageModel =
      to: contact
      from: user
      message: $("#messageContent").val()
      timeStamp: new Date()
    Meteor.call("addContact", pair) unless Messages.findOne(to: contact, from: user)?
    Meteor.call "addMessage", messageModel
    $("#messageContent").val ""

Template.previousContacts.helpers
  contactList: ->
    contacts = Meteor.user().contacts
    contacts.sort (a, b)-> b.favorite - a.favorite
  contactExists: (contactId)-> userExists contactId

Template.previousContacts.events
  "click .conversation": (event)->
    $elem = $ event.currentTarget
    if $elem.hasClass "media-body" then $elem = $elem.parent()
    Session.set "currentContact", $elem.data "id"


sendTo window, isFavorite: (id) ->
  for c in Meteor.user().contacts
    if c.contact is id then return c.favorite
    
Template.favoriteContact.helpers
  favoriteButton: -> Render.button
    icon: if isFavorite @id then 'star' else 'star-o'
    class: 'pull-right'
    text: 'Favorite'
    type: 'info'
    dataId: @id
    onclick: ->
      # TODO: May want to add an event handler instead of inserting into page
      Meteor.call "toggleContact",
        user: Meteor.userId()
        contact: @data 'id'


messageSort = (value)->
  if value? then Session.set 'messageSort', value else Session.get 'messageSort'

Template.messageList.created = ()-> messageSort 'time' unless messageSort()?

Template.messageList.helpers
  isTime: -> messageSort() is 'time'
  isUnread: -> messageSort() is 'unread'
  isInbound: -> messageSort() is 'inbound'
  isFavorite: -> messageSort() is 'favorite'
  isTimeActive: -> if messageSort() is 'time' then 'active'
  isUnreadActive: -> if messageSort() is 'unread' then 'active'
  isInboundActive: -> if messageSort() is 'inbound' then 'active'
  isFavoriteActive: -> if messageSort() is 'favorite' then 'active'
  conversationList: ->
    conversations = Meteor.user().conversations
    switch messageSort()
      when 'time'
        conversations.sort (a, b)->
          Messages.findOne(b.message).timeStamp - Messages.findOne(a.message).timeStamp
      when 'unread'
        conversations.sort (a, b)->
          #TODO: Check if inbound before getting read status
          Messages.findOne(a.message).read - Messages.findOne(b.message).read
      when 'inbound'
        conversations.sort (a, b)-> inbound(b.message) - inbound(a.message)
      when 'favorite'
        conversations.sort (a, b)-> favorite(b.contact) - favorite(a.contact)
    conversations

Template.messageList.events
  "change .sortSelector": (event)->
    $elem = $ event.currentTarget
    messageSort $elem.val() if $elem.is(":checked")
  "click .conversation": (event)->
    $elem = $ event.currentTarget
    unless $elem.hasClass "media" then $elem = $elem.parent()
    Session.set "currentContact", $elem.data "id"
