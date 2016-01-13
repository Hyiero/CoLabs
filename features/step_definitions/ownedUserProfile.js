// TODO: app.pages and app['component name']
// app.modals.loginOrRegister.isVisible()
// app.pages.splash.buttons.findProject.click()
// app.pages.splash.buttons.findUser.click()
// app.pages.profile.buttons.resendEmail.click()
// app.views.toasts(0).isVisible()
// app.views.toasts(0).contains('Success')

require.call(this, '../lib/util.coffee')
var app = require('../lib/app.js')


module.exports = function()
{

  this.Given(/^I am a logged in, unverified user$/, function () {
    browser.url(app.baseUrl)
    client.waitForExist(app.views.nav.profileInfo)
  })
  
  var page = app.pages.profile
  
  this.Given(/^I am on the profile page$/, function () {
    browser.url(page.url)
    client.waitForExist(page.views.username)
  })

  this.When(/^I click on the verify email button$/, function () {
    page.views.verifyEmailButton.click()
  })

  this.Then(/^I see a (.*) toast containing "(.*)"$/, function (type, text, callback) {
    client.waitForExist(app.elems.toasts(0))
    app.views.toasts(0).getText(text)
      .then(function (text) {
        if (!text) callback(fail('The most recent toast does not say "sent"!'))
      })
      .then(function () {
        return app.views.toasts(0).getAttribute('class')
          .then(function (attr) {
            if (attr.indexOf(type) === -1)
              callback(fail('The most recent toast was not of type "' + type + '"'))
            else callback()
          })
      })
    
  })
}
