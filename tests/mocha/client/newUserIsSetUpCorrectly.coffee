MochaWeb?.testOnly ->
  describe 'client accounts',->
    it 'Create a test user in database',(done)->
      Accounts.createUser({username:'tester',email:'tester@email.com',password:'test'},
        try
          user = Meteor.users.findOne({username: 'tester'})
          chai.assert.equal user.username, 'tester'
          done()
        catch
          done()
      )
    #Try and catch is needed when we have errors that might need to be handled or are expected
    it 'Attempt to remove user from client and receive not permitted error', (done)->
      try
        Meteor.users.remove({username: 'tester'})
        done()
      catch
        chai.assert.equal _error.message, 'Not permitted. Untrusted code may only remove documents by ID. [403]'
        done()
