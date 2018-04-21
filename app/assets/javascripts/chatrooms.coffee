$ ->
  $('#new_message').on 'keypress', (e) ->
    if e && e.keyCode == 13
      e.preventDefault()
      $(this).submit()
  $('#new_message').on 'submit', (e) ->
    e.preventDefault()
    chatroom_id = $("[data-behavior='messages']").data("chatroom-id")
    body = $('#message_body')
    App.chatrooms.send_message(chatroom_id, body.val())
    # Clear out the message box
    body.val ''
