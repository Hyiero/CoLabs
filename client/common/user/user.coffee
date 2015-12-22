Template.userProfile.helpers
  messageContactButton: -> Render.button
    icon: 'send'
    text: 'Message'
    dataContext: username: @username
    onclick: -> Router.go "/inbox/#{(@data 'context')?.username}"
  inviteUserToProjectButton: -> Render.button
    icon: 'plus'
    text: 'Invite to Project'
    onclick: -> Modal.show 'inviteToProjectModal'
  resendEmailButton: -> Render.buttonImportant
    icon: 'share'
    text: 'Resend'
    dataContext: emails: @emails
    onclick: ->
      if (@data 'context')?.emails?.length > 0
        message = ['Verificiation Email Sent', 'Go check your email address!']
        Meteor.call 'sendVerificationEmail', Meteor.userId(), (err) ->
          unless err? then toast.success message...
  editProfileButton: -> Render.button
    icon: 'edit'
    text: 'Edit Profile'
    onclick: -> Router.go '/profile/edit'
  isProfile: -> 'profile' in Router.current().url.split '/'
  firstEmail: -> if @emails?.length > 0 then @emails[0].address else ''
  isVerifiedUser: -> CoLabs.isVerifiedUser()
  hasEmailSaved: -> @emails?.length > 0
  hasVerifiedEmail: -> (@emails[0]?.filter (e) -> e.verified).length > 0
  otherProfileAndLoggedIn: ->
    # TODO: Make sure it's not the logged in user
    CoLabs.isLoggedIn() and 'user' in Router.current().url.split '/'

Template.inviteToProjectModal.onCreated ->
  @subscribe 'myProjects'

Template.inviteToProjectModal.helpers
  buttonClose: -> Render.buttonClose
    class: 'pull-right'
    dataDismiss: 'modal'
  inviteButton: -> Render.button
    text: 'Choose Project'
    dataContext: projectId: @_id
    onclick: ->
      user = Meteor.users.findOne(username:Router.current().params.username)._id
      Meteor.call 'inviteUserToProject',
        userId: user
        projectId: (@data 'context').projectId
  adminProjects: ->
    # TODO: Remove projects user is already invited to
    Projects.find(admins: Meteor.userId()).fetch()
