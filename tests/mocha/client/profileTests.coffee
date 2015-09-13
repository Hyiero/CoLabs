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
      )
      try
        updatedUser=Meteor.users.findOne({username:'tester'})
        chai.assert.equal updatedUser.firstName, "test firstName"
        done()
      catch
        done()
    
    it 'Attempt to send notification from user', (done) ->
        SendOneNotification("testType","Today","Juan")
        try
          newNotification=Notifications.findOne({type:"testType"})
          chai.assert.equal newNotification.sender "Juan"
          Notifications.remove({type:"testType"})
          done()
        catch
          done()

    #Try and catch is needed when we have errors that might need to be handled or are expected
    it 'Attempt to remove user from client and receive not permitted error', (done)->
      try
        Meteor.users.remove({username: 'tester'})
        done()
      catch
        chai.assert.equal _error.message, 'Not permitted. Untrusted code may only remove documents by ID. [403]'
        done()