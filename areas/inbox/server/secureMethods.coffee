CoLabs.methods
  toggleContact: (contactId)->
    user = Meteor.userId()
    contacts = Meteor.users.findOne(user)?.contacts
    for contact in contacts
      if contact.contact is contactId
        foundAny = true
        contact.favorite = not contact.favorite
    if foundAny?
      Meteor.users.update user, $set:
        contacts: contacts
