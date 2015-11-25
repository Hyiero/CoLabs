CoLabs.methods
  toggleContact: (contact)->
    user = Meteor.userId()
    contacts = Meteor.users.findOne(user)?.contacts
    for contact in contacts
      if contact.contact is contact
        found = true
        contact.favorite = not contact.favorite
    if found?
      Meteor.users.update user, $set:
        contacts: contacts
