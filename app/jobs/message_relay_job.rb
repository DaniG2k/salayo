class MessageRelayJob < ApplicationJob
  queue_as :high

  def perform(message_id)
    message = Message.find message_id
    ActionCable.server.broadcast("chatrooms:#{message.chatroom.id}",
      {
        message: MessagesController.render(
          partial: 'dynamic_message',
          locals: {message: message}
        ),
        chatroom_id: message.chatroom.id
      }
    )
  end
end
