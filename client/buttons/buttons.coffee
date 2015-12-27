Template.skillButton.events
  'click': (e) ->
    e.preventDefault()
    skills = Session.get 'skills'
    skills = skills.filter (skill)-> skill isnt e.target.value
    Session.set 'skills', skills

Template.interestButton.events
  'click': (e) ->
    e.preventDefault()
    interests = Session.get 'interests'
    interests = interests.filter (interest)-> interest isnt e.target.value
    Session.set 'interests', interests