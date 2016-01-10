###
Should be able to display multiple alerts simultaneously
Alerts should be closable
Alerts will fade in for a second, remain for 5 seconds, then fade out
Newer alerts will push into a "stack"
Older alerts will animate downward
If the alert stack is the height of the window,
  the overflowing alert should be removed
###

if Meteor.isClient then Meteor.startup ->
  window.toast = (new ->
    _ = @
    
    htmlList = ->
      if $('#toast-list').length is 0
        $(document.body).append '<div id="toast-list">'
      $ '#toast-list'
    
    @list = []
    @push = (type, title, rawMessage, duration) ->
      if not duration or duration <= 0 then duration = 5000
      _.list.push {
        type: type.toString()
        title: title
        rawMessage: rawMessage
        duration: duration
        time: new Date
      }
    
    createToastHelper = (type) ->
      _[type] = (title, rawMessage, duration) ->
        _.push type, title, rawMessage, duration
        
    createToastHelper t for t in ['success', 'warning', 'info', 'danger']
    
    @logEnabled = false
    
    @queue = []
    @apply = -> fn() for fn in _.queue
    
    createHtmlHelper = (nodeName, isVoid) ->
      if isVoid then (attrObj) ->
        attributes = ''
        for name, val of attrObj
          attributes += " #{name}=\"#{val}\""
          
        "<#{nodeName}#{attributes}/>"
        
      else (args...) ->
        attributes = ''
        htmlString = ''
        if not args[0]?.toUpperCase?
          for name, val of args[0]
            attributes += " #{name}=\"#{val}\""
          for text in args.slice 1
            htmlString += text
        else
          for text in args
            htmlString += text
        
        "<#{nodeName}#{attributes}>#{htmlString}</#{nodeName}>"
    
    for nodeName in 'div h6 p'.split ' '
      window[nodeName] = createHtmlHelper nodeName
    
    drawToast = (ind, type, title, rawMessage) ->
      div({"data-ind": ind, class: "toast toast-#{type} alert alert-#{type}"}
        h6 title
        p rawMessage
      )
    
    @index = 0
    @paused = false
    @update = ->
      if not _.paused
        newToasts = []
        oldToasts = []
        for toast in _.list
          if toast.ind? then oldToasts.push toast
          else newToasts.push toast
        
        $htmlList = htmlList()
        for t in newToasts
          _.index++
          ind = new Number _.index
          {type, title, rawMessage, duration} = t
          toastHtml = drawToast ind, type, title, rawMessage
          t.ind = ind
          $toastHtml = $ toastHtml
          $htmlList.append $toastHtml unless not toastHtml
          $toastHtml.css(opacity:0).animate opacity:1, 400
          
          setTimeout (->
            _.paused = true
            htmlList().children("[data-ind=#{ind}]").fadeOut 800
            setTimeout (->
              htmlList().children("[data-ind=#{ind}]").remove()
              _.paused = false
            ), 800
          ), duration + 400
          
    setInterval _.update, 10
    _
  )
  