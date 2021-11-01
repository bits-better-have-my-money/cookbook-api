class MessagesController < ApplicationController
  before_action :authenticate_user, except: [:index]

  def index
    messages = Message.all.order(created_at: :desc)
    render json: messages
  end

  def create
    message = Message.new(
      user_id: current_user.id,
      body: params[:body]
    )
    if message.save
      # broadcast to the channel
      ActionCable.server.broadcast "messages_channel", {
        id: message.id,
        body: message.body,
        created_at: message.created_at,
        user: {
          id: message.user.id,
          name: message.user.name,
          email: message.user.email
        }
      }

      render json: message
    else
      render json: {errors: message.errors.full_messages}, status: :unprocessable_entity
    end
  end
end
