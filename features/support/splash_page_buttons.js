var ButtonNamespace = require.call(this, '../Models/Components/stuff.js')

module.exports = function()
{
    ButtonNamespace.ButtonExport();

    this.Given(/^I have visited the splash page/, function () {
        browser.url(ButtonNamespace.baseUrl);
    });

    this.When(/^I search for "([^"]*)"$/, function (arg1) {

    });

    this.Then(/^I see "([^"]*)"$/, function (arg1) {
        ButtonNamespace.SplashPage.FindProjectsButton.IsVisible();
    });
}

