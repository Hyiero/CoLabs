Template.listFilter.helpers
  tags: -> Session.get('tagSearch') ? ''
  name: -> Session.get('nameSearch') ? ''

Template.listFilter.events
  'input #tagFilter': (event) ->
    Session.set 'tagSearch', $(event.currentTarget).val()
  'input #nameFilter': (event) ->
    Session.set 'nameSearch', $(event.currentTarget).val()
  'click #clearTagFilter': (event) ->
    $('#tagFilter').val ''
    Session.set 'tagSearch', ''
  'click #clearNameFilter': (event) ->
    $('#nameFilter').val ''
    Session.set 'nameSearch', ''
  'click .search-clear': (event) ->
    $(event.currentTarget).prev().val('').trigger 'input'

Template.listResults.helpers
  messageButton: -> Render.button
    icon: 'send'
    text: 'Message'
    class: 'pull-right'
    dataContext: @username
    onclick: -> Router.go "/inbox/#{@data 'context'}"
  inviteButton: -> Render.button
    icon: 'user-plus'
    text: 'Invite'
    class: 'pull-right'
    dataContext: @_id
    onclick: -> Meteor.call 'inviteUserToProject',
      userId: @data 'context'
      projectId: Router.current().params.id
  tags: -> if @tags? then (@tags).join ', '
  time: -> (new Date this.createdAt).toLocaleTimeString()
  isLoggedIn: -> Meteor.user()?
  isUser: (type) -> type is 'user'
  isInvite: -> 'invite' in Router.current().url.split '/'
  filterInput: ->
    nameInput = Session.get('nameSearch') ? ''
    tagInput = Session.get('tagSearch') ? ''
    "#{nameInput} | #{tagInput}"