module Api
  module V1
    module Users
      class PasswordsController < ExceptionsController
        authorize_resource class: :user_password

        def create
          @password = User::Password.new(current_user)
          if @password.change(password_params)
            render json: { success: true }
          else
            render json: { errors: @password.errors }, status: 422
          end
        end

        private

        def password_params
          params.require(:user).permit(:original_password, :new_password, :new_password_confirmation)
        end
      end
    end
  end
end
