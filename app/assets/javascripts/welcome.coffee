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
