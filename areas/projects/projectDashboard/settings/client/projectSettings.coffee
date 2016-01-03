Template.projectSettings.onCreated ->
  @subscribe 'oneProject', Router.current().params.id

Template.projectSettings.helpers
  editProjectButton: -> Render.button
    type: 'primary'
    text: 'Edit Project'
    icon: 'edit'
    onclick: -> Router.go "/project/#{Router.current().params.id}/edit"
  inviteUsersButton: -> Render.button
    type: 'info'
    text: 'Invite Users'
    icon: 'user'
    onclick: -> Router.go "/project/#{Router.current().params.id}/invite"
  adminsButton: -> Render.button
    type: 'danger'
    text: 'Add/remove admins'
    icon: 'plus'
    onclick: -> Router.go "/project/#{Router.current().params.id}/admins"
