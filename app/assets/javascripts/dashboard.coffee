$(document).ready ->
  $('#show_box').click ->
    $('#dropdown_box').fadeIn(100)
    return
  $('#show_box').blur ->
    $('#dropdown_box').fadeOut(100)
    return
  return
