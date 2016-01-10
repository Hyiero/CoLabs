module.exports = function()
{
    this.Given(/^I have visited Google$/, function () {
        browser.url('http://google.com');
    });

    this.When(/^I search for "([^"]*)"$/, function (arg1) {
        browser.setValue('input[name="q"]',arg1);
        browser.keys(['Enter']);
    });

    this.Then(/^I see "([^"]*)"$/, function (arg1) {
        client.waitForExist('a='+arg1);
    });
}

