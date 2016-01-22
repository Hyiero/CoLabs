require.call this, '../lib/util.coffee'
app = require '../lib/app.coffee'

removeAllUsers = -> Meteor.users.remove(username: 'test')
getAllUsers = -> Meteor.users.find().fetch()

module.exports = ->
  @Given /^I am at the (.*) page$/, (page) ->
    switch page
      when 'splash'
        browser.url app.baseUrl
      when 'profile'
        browser.url app.pages.profile.url
      else
        browser.url app.baseUrl
  @When /^I remove all users$/, ->
    server.execute removeAllUsers
  @Then /^No users remain$/, ->
    users = (client.execute getAllUsers).value
    console.log users
    expect(users.length).toBe 0
  @Then /^I see a (.*) toast containing "(.*)"$/, (type, text) ->
    client.waitForExist '.toast'
    toastId = client.element('.toast').value.ELEMENT
    toastClass = client.elementIdAttribute(toastId, 'class').value
    toastText = client.elementIdText(toastId).value
    expect(toastClass).toContain type
    expect(toastText).toContain text
