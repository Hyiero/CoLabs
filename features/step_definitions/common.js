require.call(this, '../lib/util.coffee')
var app = require('../lib/app.js')

module.exports = function() {
  this.Given(/^I am at the (.*) page$/, function (page) {
    switch (page) {
      case 'splash':
        browser.url(app.baseUrl)
        break;
      case 'profile':
        browser.url(app.pages.profile.url)
        break;
      default:
        browser.url(app.baseUrl)
    }
  })

  this.Then(/^I see a (.*) toast containing "(.*)"$/, function (type, text) {
    client.waitForExist('.toast')

    var toastId = client.element('.toast').value.ELEMENT
    var toastClass = client.elementIdAttribute(toastId, 'class').value
    var toastText = client.elementIdText(toastId).value

    if (toastClass.indexOf(type) == -1) {
      fail('The most recent toast was not of type "' + type + '"!')
    } else if (toastText.indexOf(text) == -1) {
      fail('The most recent toast does not say "' + text + '"!')
    }
  })
}