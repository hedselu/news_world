module Api
  module V1
    class AuthenticationController < ApplicationController
      before_action :refresh_user_session

      def current_user
        @current_user = User.find_by_token(@token) if authenticated_user?
        @current_user ||= User.new
      end

      protected

      def refresh_user_session
        current_user.refresh_session! unless current_user.guest?
      end

      private

      def authenticated_user?
        @token = request.headers['Authorization'].try(:sub, /Token\s/, '')
      end
    end
  end
end
