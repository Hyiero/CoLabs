Template.projectAdminList.onCreated ->
  @subscribe 'oneProject', Router.current().params.id
  @subscribe 'projectAdmins', Router.current().params.id

Template.projectAdminList.helpers
  projectAdmins: ->
    (Meteor.users.findOne(admin) for admin in Projects.findOne().admins)

Template.projectUserList.onCreated ->
  @subscribe 'oneProject', Router.current().params.id
  @subscribe 'projectUsers', Router.current().params.id

Template.projectUserList.helpers
  grantAdminButton: -> Render.buttonSave
    icon: 'plus'
    text: 'Grant power'
    dataContext: userId: @_id
    onclick: -> Meteor.call 'grantProjectAdmin',
      userId: @data('context').userId
      projectId: Router.current().params.id
  projectUsers: ->
    project = Projects.findOne()
    users = project.users.filter (e) -> e not in project.admins
    (Meteor.users.findOne(user) for user in users)
