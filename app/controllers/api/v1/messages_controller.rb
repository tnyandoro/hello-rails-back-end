module Api
    module V1
        class MessagesController < ApplicationController
            def index 
                messages = Message.all
                render json: MessageSerializer.new(messages).serialized_json
            end

            def show
                message = Message.find(params[:id])
                render json: MessageSerializer.new(message).serialized_json
            end

            def create
                message = Message.new(message_params)
                if message.save
                    render json: MessageSerializer.new(message).serialized_json
                else
                    render json: {errors: message.errors.full_messages}, status: 422
                end
            end

            def update
                message = Message.find(params[:id])
                if message.update(message_params)
                    render json: MessageSerializer.new(message).serialized_json
                else
                    render json: {errors: message.errors.full_messages}, status: 422
                end
            end

            def destroy
                message = Message.find(params[:id])
                message.destroy
                render json: {message: "Message deleted"}
            end

            private

            def message_params
                params.require(:message).permit(:greeting, :user_id)
            end
        end
    end
end
