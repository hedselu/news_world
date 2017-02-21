module Api
  module V1
    module Users
      class AccountsController < ExceptionsController
        authorize_resource class: :user_account

        def show
          render json: current_user
        end

        def update
          user = current_user
          update_params = user_params
          update_params[:categories_set] = true if categories_not_set?
          if user.update(update_params)
            render json: { success: true }
          else
            render json: { errors: user.errors }
          end
        end

        private

        def categories_not_set?
          user_params[:category_ids].present? && !current_user.categories_set?
        end

        def user_params
          params.require(:user).permit(:email, category_ids: [])
        end
      end
    end
  end
end
