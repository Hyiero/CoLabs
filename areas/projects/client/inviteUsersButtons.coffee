Template.inviteUsersButtons.events 
  "click #inviteUsersToProject": (event) ->
    selectedCheckboxes=$('.selectedUserCheckbox')
    for checkbox in selectedCheckboxes
      if(checkbox.checked)
        userId=checkbox.attributes["value"].value
        invited=CoLabs.IsUserInvitedToProject(userId,Session.get("selectedProjectId"))
        cb={}
        console.log invited
        if invited is "false"
          Meteor.call 'inviteUserToProject', userId, Session.get("selectedProjectId"), (err,data) ->
            if data == true then toast.success "Invitation","User invited to project",5000
            else toast.danger "Invitation","Something went wrong while sending the invitation",5000
        else
          toast.warning "Invitation",
            "This user has a pending invitation to this project.",
            3000