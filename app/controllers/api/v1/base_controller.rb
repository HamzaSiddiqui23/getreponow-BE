# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      before_action :authenticate_request

      private

      def authenticate_request
        header = request.headers['Authorization']
        token = header.split(' ').last if header

        render json: { error: 'Missing Token' }, status: :unauthorized and return if token.nil?

        decoded = JwtToken.decode(token)
        session = Session.find_by(token: decoded[:token]) if decoded
        @current_user = session.resource if decoded
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end

      def current_company
        @current_user.company
      end

      attr_reader :current_user
    end
  end
end
