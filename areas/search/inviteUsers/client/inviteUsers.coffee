Template.inviteUsersButtons.events 
  "click #inviteUsersToProject": (event) ->
    for checkbox in $ '.selectedUserCheckbox'
      if checkbox.checked
        user = checkbox.attributes["value"].value
        project = Session.get 'selectedProjectId'
        if CoLabs.IsUserInvitedToProject(user, project)
          Meteor.call 'inviteUserToProject', { user, project }, (err,data) ->
            if data then toast.success "Invitation","User invited to project",5000
            else toast.danger "Invitation","Something went wrong while sending the invitation",5000
        else
          toast.warning "Invitation",
            "This user has a pending invitation to this project.",
            3000
