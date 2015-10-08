Package.describe({
    summary: 'Helper methods for CoLabs',
    version: '1.0.0',
    name: 'helpers'
})

Package.onUse(function(api) {
    api.use(['coffeescript'], ['client', 'server'])
    api.addFiles('helpers.coffee')
    api.export(['Helpers', 'sendTo'], ['client', 'server'])
})
