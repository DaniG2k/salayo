class ContactMessagesController < ApplicationController
  def new
    @message = ContactMessage.new
  end

  def create
  end
end
