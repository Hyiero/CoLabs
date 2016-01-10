// TODO: app.pages and app['component name']
// app.modals.loginOrRegister.isVisible()
// app.pages.splash.buttons.findProject.click()
// app.pages.splash.buttons.findUser.click()
// app.pages.profile.buttons.resendEmail.click()
// app.elems.toasts(0).isVisible()
// app.elems.toasts(0).contains('Success')

app = require('../lib/app.js')

module.exports = function()
{

    this.Given(/^I have visited the splash page/, function () {
        browser.url(app.baseUrl);
    });

    this.When(/^I search for "([^"]*)"$/, function (arg1) {

    });

    this.Then(/^I see "([^"]*)"$/, function (arg1) {
        app.pages.splash.buttons.searchProjects.isVisible()
    });
}

