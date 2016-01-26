require.call this, '../lib/util.coffee'
app = require '../lib/app.coffee'

modal = app.modals.loginOrRegister
nav = app.views.nav

module.exports = ->
  @When /^I create user "(.*)"$/, (username) ->
    if !nav.links.signIn.isDisplayed()
      nav.buttons.collapse.click()
    nav.links.signIn.click()
    modal.inputs.signupOption.click()
    modal.inputs.username.setValue username
    modal.inputs.password.setValue '123'
    modal.inputs.verifyPassword.setValue '123'
    modal.buttons.submit.click()
  @When /^I click message user$/, ->
    app.pages.user.buttons.messageUser.click()
  @When /^I click the first message$/, ->
    client.pause 500
    messageId = client.element('#message').value.ELEMENT
    client.elementIdClick(messageId)
  @When /^I send "(.*)"$/, (text) ->
    app.pages.inboxChat.inputs.chat.setValue text
    app.pages.inboxChat.buttons.submit.click()
  @Then /^I see the "(.*)" label$/, (text) ->
    labelId = client.element('#contactName').value.ELEMENT
    label = client.elementIdText(labelId).value
    expect(label).toBe text
  @Then /^I see a new message$/, ->
    client.pause 500
    messages = client.elements('.msg').value
    expect(messages.length).toBe 1
