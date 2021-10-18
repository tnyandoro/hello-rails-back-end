# app/controllers/api/v1/messages_controller.rb
module Api
  module V1
    class Api::V1::MessagesController < ApplicationController
      def index
        @messages = Message.all
        render json: @messages
      end

      def show
        @message = Message.find(params[:id])
        render json: @greeting
      end

      def create
        @message = Message.new(message_params)
        if @message.save
          render json: @message, status: :created
        else
          render json: @message.errors, status: :unprocessable_entity
        end
      end
    end
  end
end