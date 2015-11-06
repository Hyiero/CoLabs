CoLabs.methods
  toggleContact: (contact)->
    user = Meteor.userId()
    contacts = Meteor.users.findOne(user).contacts
    for contact in contacts
      if contact.contact is contact
        contact.favorite = not contact.favorite
    Meteor.users.update user, $set:
      contacts: contacts
