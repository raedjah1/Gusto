class MessagesController < ApplicationController
    before_action :authenticate_user!

    def index
      messages = Message.where(sender: current_user).or(Message.where(receiver: current_user))
      render json: messages
    end

    def create
      message = Message.new(message_params.merge(sender: current_user))
      if message.save
        render json: message, status: :created
      else
        render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def message_params
      params.require(:message).permit(:receiver_id, :content)
    end
end
