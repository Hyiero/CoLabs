require.call this, '../lib/util.coffee'
app = require '../lib/app.coffee'

modal = app.modals.loginOrRegister
nav = app.views.nav

removeAllUsers = -> Meteor.users.remove username: $in: ['test', 'test2', 'test3']
getAllUsers = -> Meteor.users.find().fetch()

module.exports = ->
  @Given /^I am signed in as "(.*)"$/, (username) ->
    browser.url app.baseUrl
    if !nav.links.signIn.isDisplayed()
      nav.buttons.collapse.click()
    nav.links.signIn.click()
    modal.inputs.username.setValue username
    modal.inputs.password.setValue '123'
    modal.buttons.submit.click()
    client.pause 500
  @Given /^I am at the (.*) page$/, (page) ->
    [page, data] = page.split ' '
    switch page
      when 'splash'
        browser.url app.baseUrl
      when 'profile'
        browser.url app.pages.profile.url()
      when 'user'
        browser.url app.pages.user.url(data)
      when 'inbox'
        browser.url app.pages.inbox.url()
      else
        browser.url app.baseUrl
  @When /^I remove all users$/, ->
    server.execute removeAllUsers
  @Then /^No users remain$/, ->
    client.pause 500
    users = (client.execute getAllUsers).value
    expect(users.length).toBe 0
  @Then /^I see a (.*) toast containing "(.*)"$/, (type, text) ->
    client.waitForExist '.toast'
    toastId = client.element('.toast').value.ELEMENT
    toastClass = client.elementIdAttribute(toastId, 'class').value
    toastText = client.elementIdText(toastId).value
    expect(toastClass).toContain type
    expect(toastText).toContain text
  @Then /^I don't see a nav badge$/, ->
    if !nav.links.signOut.isDisplayed()
      nav.buttons.collapse.click()
      client.pause 500
    expect(client.elements('.badge').value.length).toBe 0
  @Then /^I see a nav badge$/, ->
    if !nav.links.signOut.isDisplayed()
      nav.buttons.collapse.click()
      client.pause 500
    expect(client.elements('.badge').value.length).toBeGreaterThan 0
  @Then /^I sign out$/, ->
    client.pause 500
    if !nav.links.signOut.isDisplayed()
      nav.buttons.collapse.click()
      client.pause 500
    nav.links.signOut.click()
