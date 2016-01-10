$do = (selector, sequence) ->
  $elem = $ selector
  for fnName, args of sequence
    if sequence.hasOwnProperty fnName
      if not args? then args = undefined
      else if args not instanceof Array
        args = [args]
      $elem = $elem[fnName](args...)
  $elem

# Copied from http://www.minimit.com/articles/lets-animate/parallax-backgrounds-with-centered-content
fullscreenFix = ->
  $do '.content-b', each:->
    if $(@).innerHeight() <= $('body').height()
      $do @,
        closest: '.fullscreen'
        addClass: 'not-overflow'

### resize background images ###

backgroundResize = ->
  windowH = $(window).height()
  $do '.background', each:->
    path = $ @
    # variables
    contW = path.width()
    contH = path.height()
    imgW = path.data 'img-width'
    imgH = path.data 'img-height'
    ratio = imgW / imgH
    # overflowing difference
    diff = parseFloat path.data 'diff'
    diff = 0 unless diff
    # remaining height to have fullscreen image only on parallax
    remainingH = 0
    if path.hasClass 'parallax' and not $('html').hasClass 'touch'
      maxH = if contH > windowH then contH else windowH
      remainingH = windowH - contH
    # set img values depending on cont
    imgH = contH + remainingH + diff
    imgW = imgH * ratio
    # fix when too large
    if contW > imgW
      imgW = contW
      imgH = imgW / ratio
    
    path.data 'resized-imgW', imgW
    path.data 'resized-imgH', imgH
    window.requestAnimationFrame ->
      path.css 'background-size', "#{imgW}px #{imgH}px"

### set parallax background-position ###

parallaxPosition = ->
  heightWindow = $(window).height()
  topWindow = $(window).scrollTop()
  bottomWindow = topWindow + heightWindow
  currentWindow = (topWindow + bottomWindow) / 2
  $do '.parallax', each:->
    path = $ @
    height = path.height()
    top = path.offset().top
    bottom = top + height
    # only when in range
    if bottomWindow > top and topWindow < bottom
      imgW = path.data 'resized-imgW'
      imgH = path.data 'resized-imgH'
      # min when image touch top of window
      min = 0
      # max when image touch bottom of window
      max = -imgH + heightWindow
      # overflow changes parallax
      overflowH = if height < heightWindow then imgH - height else imgH - heightWindow
      # fix height on overflow
      top = top - overflowH
      bottom = bottom + overflowH
      # value with linear interpolation
      value = min + (max - min) * (currentWindow - top) / (bottom - top)
      # set background-position
      orizontalPosition = path.data 'oriz-pos'
      orizontalPosition = if orizontalPosition then orizontalPosition else '50%'
      window.requestAnimationFrame ->
        path.css 'background-position', "#{orizontalPosition} #{value}px"

Template.splash.onRendered ->
  if window.ontouchstart
    document.documentElement.className = document.documentElement.className + ' touch'
  if !$('html').hasClass('touch')
    # background fix
    $('.parallax').css 'background-attachment', 'fixed'

  $(window).resize fullscreenFix
  fullscreenFix()
  $(window).resize backgroundResize
  $(window).focus backgroundResize
  backgroundResize()
  if !$('html').hasClass('touch')
    $(window).resize parallaxPosition
    #$(window).focus(parallaxPosition)
    $(window).scroll parallaxPosition
    parallaxPosition()

#mquery = ($fn, context) ->
  #for name, fn of $fn
    # instead of  $(sel).addClass('class').html()
    # do html addClass 'class' $ sel
    
    # istead of $(sel).prev().children('test').on('click',fn)
    # do on 'click', fn, children 'test', prev $ sel


    