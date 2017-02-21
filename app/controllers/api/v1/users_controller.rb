module Api
  module V1
    class UsersController < ExceptionsController
      skip_before_action :refresh_user_session, only: :create
      before_action :set_user, only: %i(show update destroy)
      authorize_resource

      def index
        @users = User.where(role: 'user')
        render json: @users
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: { success: true }
        else
          render json: { errors: user.errors }, status: 422
        end
      end

      def show
        if @user
          render json: @user
        else
          render json: { error: 'Not found' }, status: 404
        end
      end

      def destroy
        if @user.try(:destroy)
          render json: { success: true }
        else
          render json: { error: 'Not found' }, status: 404
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:login, :email, :password, :password_confirmation)
      end
    end
  end
end
