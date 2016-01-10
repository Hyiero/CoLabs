
Function::getter = (prop, get) ->
  Object.defineProperty @prototype, prop, {get, configurable: yes}

class Button
  myId: ''
  constructor: (@id) -> myId=@id
  @getter 'click', -> client.click("#"+myId)
  @getter 'isPresent', -> client.waitForExist("#"+myId);

class SplashPage
  FindProjects = new Button('#findProjects')