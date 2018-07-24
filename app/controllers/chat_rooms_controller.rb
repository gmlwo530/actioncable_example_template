class ChatRoomsController < ApplicationController
  before_action :authenticate_user!
  def index
    @chat_rooms = ChatRoom.includes(:chat_messages).all
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = current_user.chat_rooms.build(title: params[:title])

    if @chat_room.save
      redirect_to chat_room_path(@chat_room)
    else
      render 'new'
    end
  end

  def show
    @chat_room = ChatRoom.includes(:chat_messages).find_by(id: params[:id])
    @chat_message = ChatMessage.new
  end
end
