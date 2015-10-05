Package.describe({
    summary: 'CoffeeScript Markup Language',
    version: '0.0.1',
    name: 'csml'
})

Package.onUse(function(api) {
    api.use(['coffeescript'], ['client'])
    api.addFiles('csml.coffee')
    api.export('Csml', ['client'])
})
