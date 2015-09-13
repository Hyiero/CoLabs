Template.inviteUsersButtons.events 
    "click #inviteUsersToProject": (event) ->
        selectedCheckboxes=$('.selectedUserCheckbox')
        for checkbox in selectedCheckboxes
            if(checkbox.checked)
                userId=checkbox.attributes["value"].value
                invited=CoLabs.IsUserInvitedToProject(userId,Session.get("selectedProjectId"))
                console.log invited
                user=Meteor.users.findOne({_id:userId})
                if invited is "false"
                    Meteor.call 'inviteUserToProject', userId, Session.get("selectedProjectId")
                else
                    Modal.show 'userAlreadyInvitedModal',{user:user.name}