Template.inviteUsersButtons.events 
    "click #inviteUsersToProject": (event) ->
        selectedCheckboxes=$('.selectedUserCheckbox')
        for checkbox in selectedCheckboxes
            if(checkbox.checked)
                userId=checkbox.attributes["value"].value
                Meteor.call 'inviteUserToProject', userId, Session.get("selectedProjectId")