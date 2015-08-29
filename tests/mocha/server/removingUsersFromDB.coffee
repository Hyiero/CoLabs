#Tests to make sure that we can remove users from the database on the server
MochaWeb?.testOnly ->
  describe 'server accounts',->
    it 'remove User from database',()->
      setTimeout ()->
        Meteor.users.remove({username: 'tester'})
      ,1500