Template.listFilter.helpers
  skills: -> (Session.get 'skillSearch') ? ''
  interests: -> (Session.get 'interestSearch') ? ''
  name: -> (Session.get 'nameSearch') ? ''

Template.listFilter.events
  'input #skillFilter': (event) ->
    Session.set 'skillSearch', $(event.currentTarget).val()
  'input #interestFilter': (event) ->
    Session.set 'interestSearch', $(event.currentTarget).val()
  'input #nameFilter': (event) ->
    Session.set 'nameSearch', $(event.currentTarget).val()
  'click #clearSkillFilter': (event) ->
    $('#skillFilter').val ''
    Session.set 'skillSearch', ''
  'click #clearInterestFilter': (event) ->
    $('#interestFilter').val ''
    Session.set 'interestSearch', ''
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
  skills: -> if @skills? then (@skills).join ', '
  interests: -> if @interests? then (@interests).join ', '
  time: -> (new Date this.createdAt).toLocaleTimeString()
  isLoggedIn: -> CoLabs.isLoggedIn()
  isUser: (type) -> type is 'user'
  isInvite: -> 'invite' in Router.current().url.split '/'
  filterInput: ->
    nameInput = (Session.get 'nameSearch') ? ''
    skillInput = (Session.get 'skillSearch') ? ''
    interestInput = (Session.get 'interestSearch') ? ''
    "#{nameInput} | #{skillInput} | #{interestInput}"