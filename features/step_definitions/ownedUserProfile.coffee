require.call this, '../lib/util.coffee'
app = require '../lib/app.coffee'

module.exports = ->
  @Given /^I am a logged in, unverified user$/, ->
    browser.url app.baseUrl
    client.waitForExist app.views.nav.profileInfo
  page = app.pages.profile
  @When /^I click on the verify email button$/, ->
    page.views.verifyEmailButton.click()