module Api
  module V1
    module Users
      class FollowedPeopleController < ExceptionsController
        before_action :set_followed_person, only: %i(update destroy)
        before_action :set_profession, only: %i(create update)
        authorize_resource

        def index
          render json: current_user.followed_people
        end

        def create
          followed_person = FollowedPerson.new(first_name: followed_params[:first_name],
                                               second_name: followed_params[:second_name],
                                               profession: @profession)
          current_user.followed_people << followed_person

          if current_user.save
            render json: { success: true }
          else
            render json: { errors: followed_person.errors }, status: 422
          end
        end

        def update
          if @followed_person.update(first_name: followed_params[:first_name], second_name: followed_params[:second_name]. profession: @profession)
            render json: { success: true }
          else
            render json: { errors: @followed_person.errors }, status: 422
          end
        end

        def destroy
          if @followed_person.destroy
            render json: { success: true }
          else
            render json: { errors: @followed_person.errors }, status: 422
          end
        end

        private

        def set_profession
          @profession = Profession.where(name: followed_params[:profession][:name]).first_or_create do |profession|
            profession.name = followed_params[:profession][:name]
          end
        end

        def set_followed_person
          @followed_person = FollowedPerson.find(params[:id])
        end

        def followed_params
          params.require(:user).require(:followed_person).permit(:first_name, :second_name, profession: :name)
        end
      end
    end
  end
end
