fail = (error = {}, ex) ->
  if ex? then error =
    message: error
    ex: ex
  
  throw new Error error

module.exports = ->
  this.fail = fail