// TODO: app.pages and app['component name']
// app.modals.loginOrRegister.isVisible()
// app.pages.splash.buttons.findProject.click()
// app.pages.splash.buttons.findUser.click()
// app.pages.profile.buttons.resendEmail.click()
// app.elems.toasts(0).isVisible()
// app.elems.toasts(0).contains('Success')

app = require('../lib/app.coffee')

module.exports = function()
{

    this.Given(/^I am at the splash page$/, function () {
        browser.url(app.baseUrl);
    });

    this.When(/^I observe$/, function (arg1) {

    });

    this.Then(/^I see "([^"]*)"$/, function (arg1) {
        app.pages.splash.buttons.searchProjects.isVisible()
    });
}

