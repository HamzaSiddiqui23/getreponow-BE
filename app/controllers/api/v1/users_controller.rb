# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      protect_from_forgery with: :null_session

      def index
        users = current_company.users
        render json: users
      end

      def show
        user = current_company.users.find(params[:id])

        render json: user
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :not_found
      end

      # POST /users
      def create
        user = current_company.users.new(user_params)

        if user.save
          render json: user, status: :created
        else
          render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /users/:id
      def update
        user = current_company.users.find(params[:id])

        if user.update(user_params)
          render json: user
        else
          render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'User not found' }, status: :not_found
      end

      # Strong parameters to ensure only permitted fields are passed
      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :phone, :password, :primary) # Add any other fields as needed
      end
    end
  end
end
