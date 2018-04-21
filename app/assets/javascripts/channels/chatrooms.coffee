# Ensure users logged in
current_user = $("meta[name='current-user']")
if current_user.length > 0
  App.chatrooms = App.cable.subscriptions.create "ChatroomsChannel",
    connected: ->
      # Called when the subscription is ready for use on the server

    disconnected: ->
      # Called when the subscription has been terminated by the server

    received: (data) ->
      # Called when there's incoming data on the websocket for this channel
      active_chatroom = $("[data-behavior='messages'][data-chatroom-id='#{data.chatroom_id}']")
      if active_chatroom.length > 0
        active_chatroom.prepend(data.message)
        first_bubble = $('.bubble').first()
        if first_bubble.attr('data-uid') != current_user.attr('data-id')
          first_bubble.addClass('bubble-alt')
      else
        $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']").css("font-weight", "bold")

    send_message: (chatroom_id, body) ->
      @perform "send_message", {chatroom_id: chatroom_id, body: body}
