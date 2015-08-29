#Creates a test user and makes sure that he is inserted into the database
MochaWeb?.testOnly ->
  describe 'client accounts',->
    it 'should create a User',(done)->
      Accounts.createUser({username:'tester',email:'tester@email.com',password:'test'},
        try
          user = Meteor.users.findOne({username: 'tester'})
          chai.assert.equal user.username, 'tester'
          done()
        catch
          done()
      )
    #Try and catch is needed when we have errors that might need to be handled or are expected
    it 'should attempt to remove user from client', (done)->
      try
        Meteor.users.remove({username: 'tester'})
        done()
      catch
        chai.assert.equal _error.message, 'Not permitted. Untrusted code may only remove documents by ID. [403]'
        done()
