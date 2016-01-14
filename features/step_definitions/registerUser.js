
require.call(this, '../lib/util.coffee')
var app = require('../lib/app.js')

var register = {
  username: 'test',
  email: 'test@test.com',
  password: '123',
  mismatchPassword: '1234'
}

module.exports = function() {
  var modal = app.modals.loginOrRegister
  var nav = app.views.nav

  this.Given(/^I am at the register form$/, function () {
    browser.url(app.baseUrl)
    if(!nav.links.signIn.isDisplayed()) {
      nav.buttons.collapse.click()
    }
    nav.links.signIn.click()
    modal.inputs.signupOption.click()
  })

  this.When(/^I click the close button$/, function () {
    if(modal.buttons.close.isDisplayed()) {
      modal.buttons.close.click()
    }
  })

  this.When(/^I register (.*) email$/, function (email) {
    modal.inputs.username.setValue(register.username)
    if("with" == email) {
      modal.inputs.email.setValue(register.email)
    }
    modal.inputs.password.setValue(register.password)
    modal.inputs.verifyPassword.setValue(register.password)
    modal.buttons.submit.click()
  })

  this.When(/^I enter non-matching passwords$/, function () {
    modal.inputs.username.setValue(register.username)
    modal.inputs.password.setValue(register.password)
    modal.inputs.verifyPassword.setValue(register.mismatchPassword)
    modal.buttons.submit.click()
  })
  
  this.Then(/^The register modal disappears$/, function () {
    if (modal.isDisplayed())
      fail('The login or register modal is still visible!')
  })
}
