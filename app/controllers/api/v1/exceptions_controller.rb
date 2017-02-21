module Api
  module V1
    class ExceptionsController < AuthenticationController
      rescue_from CanCan::AccessDenied do |_exception|
        render json: { error: :forbidden }, status: 401
      end

      rescue_from Errors::SessionError do |_exception|
        render json: { error: 'Session has expired' }, status: 401
      end
    end
  end
end
