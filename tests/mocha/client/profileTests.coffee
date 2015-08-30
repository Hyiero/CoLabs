MochaWeb?.testOnly ->
  describe 'user update',->
    it 'Create a test user in database',(done)->
      Accounts.createUser({username:'tester',email:'tester@email.com',password:'test'},
        try
          user = Meteor.users.findOne({username: 'tester'})
          chai.assert.equal user.username, 'tester'
          done()
        catch
          done()
      )

    it 'Attempt to update his profile info', (done) ->        
    Meteor.users.update(
        {_id:Meteor.users.findOne({username:'tester'})._id}
        {$set:
            firstName:"test firstName"
            lastName:"test lastName"
            age:30
        }
      ),
        try
          updatedUser=Meteor.users.findOne({username:'tester'})
          chai.assert.equal updatedUser.firstName, "test firstName"
          done()
        catch
          done()
            
    it 'Attempt to remove user from client and receive not permitted error', (done)->
      try
        Meteor.users.remove({username: 'tester'})
        done()
      catch
        chai.assert.equal _error.message, 'Not permitted. Untrusted code may only remove documents by ID. [403]'
        done()