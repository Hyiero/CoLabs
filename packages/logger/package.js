Package.describe({
    summary: 'Logger collection and methods',
    version: '1.0.0',
    name: 'logger'
})

Package.onUse(function(api) {
    api.use(['templating'], 'client')
    api.use(['coffeescript'], ['client', 'server'])

    api.addFiles('client/logger.html')
    api.addFiles('client/logger.css')
    api.addFiles('logger.coffee')

    api.export('Logger', ['client', 'server'])
})