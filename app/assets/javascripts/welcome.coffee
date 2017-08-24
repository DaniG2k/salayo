# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  unless $('nav').data('transparent')
    $('nav').removeClass 'transparent'

$(window).scroll ->
  if $('nav').data('transparent')
    if $(document).scrollTop() > 50
      $('nav').addClass 'bg-faded'
      $('nav').removeClass 'transparent'
    else
      $('nav').addClass 'transparent'
      $('nav').removeClass 'bg-faded'
    return

# Typed.js strings
$ ->
  $('.typed-element').typed
    strings: [
      "The easiest way to find housing in <strong>South Korea</strong>."
    ]
    typeSpeed: 50
    shuffle: true
    loopCount: 3
    startDelay: 100
    backDelay: 600
  return
