# frozen_string_literal: true

module Api
  module V1
    class AuthenticationController < ApplicationController
      skip_before_action :verify_authenticity_token

      def login
        user = User.find_by(email: params[:email])
        if user&.valid_password?(params[:password]) # If using passwords
          session = Session.upsert_session_for_resource(user)
          token = session.generate_jwt
          render json: { token: token }, status: :ok
        else
          render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
      end
    end
  end
end
