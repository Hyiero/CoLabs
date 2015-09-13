Template.inviteUsersButtons.events 
    "click #inviteUsersToProject": (event) ->
        selectedCheckboxes=$('.selectedUserCheckbox')
        for checkbox in selectedCheckboxes
            if(checkbox.checked)
                userId=checkbox.attributes["value"].value
                invited=Helpers.IsUserInvitedToProject(userId,Session.get("selectedProjectId"))
                user=Meteor.users.findOne({_id:userId})
                if invited is "false"
                    Meteor.call 'inviteUserToProject', userId, Session.get("selectedProjectId")
                else
                    Modal.show 'userAlreadyInvitedModal',{user:user.name}