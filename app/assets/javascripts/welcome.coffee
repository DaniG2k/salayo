# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(window).scroll ->
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
      "room mates in <strong>New York</strong>."
      "flatmates in <strong>London</strong>."
      "룸메이트 in <strong>Seoul</strong>."
      "ルームメイト in <strong>Tokyo</strong>."
    ]
    typeSpeed: 100
    shuffle: true
    loopCount: 3
    startDelay: 100
    backDelay: 600
  return
