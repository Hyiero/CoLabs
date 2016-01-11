
var app = require('../lib/app.js')

module.exports = function()
{
  this.Given(/^I am at the register form$/, function () {
    browser.url(app.baseUrl)
    app.views.nav.links.signIn.click()
    app.modals.loginOrRegister.inputs.signupOption.click()
  })

  this.When(/^I click the close button$/, function () {
    app.modals.loginOrRegister.buttons.close.click()
  })
}
