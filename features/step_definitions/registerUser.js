
require.call(this, '../lib/util.coffee')
var app = require('../lib/app.js')

var modal = app.modals.loginOrRegister
var nav = app.views.nav
var register = {
  username: 'test',
  newUsername: 'test2',
  email: 'test@test.com',
  password: '123',
  mismatchPassword: '1234'
}

var fillForm = function (fields) {
  modal.inputs.username.setValue(fields.username)
  if (fields.email) {
    modal.inputs.email.setValue(fields.email)
  }
  modal.inputs.password.setValue(fields.password)
  if (fields.mismatchPassword) {
    modal.inputs.verifyPassword.setValue(fields.mismatchPassword)
  } else {
    modal.inputs.verifyPassword.setValue(fields.password)
  }

  modal.buttons.submit.click()
}

module.exports = function() {
  this.Given(/^I am at the register form$/, function () {
    browser.url(app.baseUrl)
    if(!nav.links.signIn.isDisplayed()) {
      nav.buttons.collapse.click()
    }
    nav.links.signIn.click()
    modal.inputs.signupOption.click()
  })

  this.When(/^I open the login modal$/, function () {
    if(!nav.links.signIn.isDisplayed()) {
      nav.buttons.collapse.click()
    }
    nav.links.signIn.click()
  })

  this.When(/^I click the register button$/, function () {
    modal.inputs.signupOption.click()
  })

  this.When(/^I click the close button$/, function () {
    modal.buttons.close.click()
  })

  this.When(/^I register (.*) email$/, function (email) {
    fillForm({
      username: email == 'without' ? register.newUsername : register.username,
      email: email == 'with' ? register.email : null,
      password: register.password
    })
  })

  this.When(/^I enter an existing (.*)/, function (field) {
    fillForm({
      username: field == 'username' ? register.username : register.newUsername,
      email: field == 'email' ? register.email : null,
      password: register.password
    })
  })

  this.When(/^I enter non-matching passwords$/, function () {
    fillForm({
      username: register.username,
      password: register.password,
      mismatchPassword: register.mismatchPassword
    })
  })

  this.Then(/^The login modal appears$/, function () {
    client.pause(500)
    expect(modal.isDisplayed()).toBe(true)
  })

  this.Then(/^The register form appears$/, function () {
    var value = modal.buttons.submit.attr('value')
    expect(value).toEqual('Sign Up')
  })
  
  this.Then(/^The register modal disappears$/, function () {
    client.pause(500)
    expect(modal.isDisplayed()).toBe(false)
  })

  this.Then(/^I sign out$/, function () {
    client.pause(500)
    if(!nav.links.signOut.isDisplayed()) {
      nav.buttons.collapse.click()
    }
    nav.links.signOut.click()
  })
}
