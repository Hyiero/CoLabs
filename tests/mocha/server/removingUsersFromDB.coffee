#Tests to make sure that we can remove users from the database on the server
MochaWeb?.testOnly ->
  describe 'server accounts',->
    it 'Removes user from database and verifies no longer there',()->
      setTimeout ()->
        Meteor.users.remove({username: 'tester'})
        user = Meteor.users.findOne({username: 'tester'})
        chai.assert.equal user.username, 'undefined'
      ,1500