module Api
  module V1
    class SessionController < ExceptionsController
      skip_before_action :refresh_user_session
      before_action :set_user, only: :create
      authorize_resource

      def create
        if authenticated?
          @user.new_session!
          render json: { user: {
            role: @user.role,
            categories_set: @user.categories_set?,
            session: { token: @user.session.token }
          } }
        else
          render json: { success: false }, status: 401
        end
      end

      def destroy
        if current_user.expire_session!
          render json: { success: true }
        else
          render json: { success: false }, status: 500
        end
      end

      private

      def authenticated?
        @user.try(:authenticate, user_params[:password])
      end

      def set_user
        @user = User.find_by_login(user_params[:login])
      end

      def user_params
        params.require(:user).permit(:login, :password)
      end
    end
  end
end
