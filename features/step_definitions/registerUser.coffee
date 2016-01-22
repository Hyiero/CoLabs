require.call this, '../lib/util.coffee'
app = require '../lib/app.coffee'

modal = app.modals.loginOrRegister
nav = app.views.nav
register =
  username: 'test'
  newUsername: 'test2'
  email: 'test@test.com'
  password: '123'
  mismatchPassword: '1234'

fillForm = (fields) ->
  modal.inputs.username.setValue fields.username
  if fields.email
    modal.inputs.email.setValue fields.email
  modal.inputs.password.setValue fields.password
  if fields.mismatchPassword
    modal.inputs.verifyPassword.setValue fields.mismatchPassword
  else
    modal.inputs.verifyPassword.setValue fields.password
  modal.buttons.submit.click()

module.exports = ->
  @Given /^I am at the register form$/, ->
    browser.url app.baseUrl
    if !nav.links.signIn.isDisplayed()
      nav.buttons.collapse.click()
    nav.links.signIn.click()
    modal.inputs.signupOption.click()
  @When /^I open the login modal$/, ->
    if !nav.links.signIn.isDisplayed()
      nav.buttons.collapse.click()
    nav.links.signIn.click()
  @When /^I click the register button$/, ->
    modal.inputs.signupOption.click()
  @When /^I click the close button$/, ->
    modal.buttons.close.click()
  @When /^I register (.*) email$/, (email) ->
    fillForm
      username: if email == 'without' then register.newUsername else register.username
      email: if email == 'with' then register.email else null
      password: register.password
  @When /^I enter an existing (.*)/, (field) ->
    fillForm
      username: if field == 'username' then register.username else register.newUsername
      email: if field == 'email' then register.email else null
      password: register.password
  @When /^I enter non-matching passwords$/, ->
    fillForm
      username: register.username
      password: register.password
      mismatchPassword: register.mismatchPassword
  @Then /^The login modal appears$/, ->
    client.pause 500
    expect(modal.isDisplayed()).toBe true
  @Then /^The register form appears$/, ->
    value = modal.buttons.submit.attr 'value'
    expect(value).toEqual 'Sign Up'
  @Then /^The register modal disappears$/, ->
    client.pause 500
    expect(modal.isDisplayed()).toBe false
  @Then /^I sign out$/, ->
    client.pause 500
    if !nav.links.signOut.isDisplayed()
      nav.buttons.collapse.click()
    client.pause 1000
    nav.links.signOut.click()
  @After
