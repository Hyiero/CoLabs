
require.call(this, '../lib/util.coffee')
var app = require('../lib/app.js')

var register = {
  username: 'test',
  email: 'test@test.com',
  password: '123',
  mismatchPassword: '1234'
}

module.exports = function()
{
  this.Given(/^I am at the register form$/, function () {
    browser.url(app.baseUrl)
    if(!app.views.nav.links.signIn.isDisplayed()) {
      app.views.nav.buttons.collapse.click()
    }
    app.views.nav.links.signIn.click()
    app.modals.loginOrRegister.inputs.signupOption.click()
  })

  this.When(/^I click the close button$/, function () {
    app.modals.loginOrRegister.buttons.close.click()
  })

  this.When(/^I register (.*) email$/, function (email) {
    app.modals.loginOrRegister.inputs.username.setValue(register.username)
    if("with" == email) {
      app.modals.loginOrRegister.inputs.email.setValue(register.email)
    }
    app.modals.loginOrRegister.inputs.password.setValue(register.password)
    app.modals.loginOrRegister.inputs.verifyPassword.setValue(register.password)
    app.modals.loginOrRegister.buttons.submit.click()
  })

  this.When(/^I enter non-matching passwords$/, function () {
    app.modals.loginOrRegister.inputs.username.setValue(register.username)
    app.modals.loginOrRegister.inputs.password.setValue(register.password)
    app.modals.loginOrRegister.inputs.verifyPassword.setValue(register.mismatchPassword)
    app.modals.loginOrRegister.buttons.submit.click()
  })
  
  this.Then(/^The register modal disappears$/, function () {
    if (app.modals.loginOrRegister.isDisplayed())
      fail('The login or register modal is still visible!')
  })

  this.Then(/^I see a (.*) toast containing "(.*)"$/, function (type, text) {
    client.waitForExist(app.elems.toasts(0))
    app.views.toasts(0).getText(text)
      .then(function (text) {
        if (!text) fail('The most recent toast does not say "sent"!')
      })
      .then(function () {
        return app.views.toasts(0).getAttribute('class')
          .then(function (attr) {
            if (attr.indexOf(type) === -1)
              fail('The most recent toast was not of type "' + type + '"')
          })
      })
    
  })
}
