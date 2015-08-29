MochaWeb?.testOnly -> #first line are basic setup for every test
  describe 'This is a Sample Test', -> #Describe what the test will do
    it 'shows you how to perform tests', -> #this is where you can go ahead and go into detail what you will actually be testing
      chai.assert.equal 5,5 #this is the test itself. If it is functional and true then we will have a successful test output