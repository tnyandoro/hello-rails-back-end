# app/controllers/api/v1/messages_controller.rb
module Api
  module V1
    class MessagesController < ApplicationController
      # protect_from_forgery with: :null_session

      def index
        messages = Message.all
        render json: MessageSerializer.new(messages).serialized_json
      end

      def show
        message = Message.find(id: params[:id]) || Message.random
        render json: MessageSerializer.new(message).serialized_json
      end

      def create
        message = Message.new(message_params)
        if message.save
          render json: MessageSerializer.new(message).serialized_json
        else
          render json: { error: message.errors.messages }, status: 422
        end
      end

      def update
        message = Message.find(params[:id])
        if message.update(message_params)
          render json: MessageSerializer.new(message).serialized_json
        else
          render json: { error: message.errors.messages }, status: 422
        end
      end

      def destroy
        message = Message.find(params[:id])

        if message.destroy
          head :no_content, status: :ok
        else
          render json: { error: message.errors.messages }, status: 422
        end
      end

      private

      def message_params
        params.require(:message).permit(:greeting, :user_id)
      end
    end
  end
end
