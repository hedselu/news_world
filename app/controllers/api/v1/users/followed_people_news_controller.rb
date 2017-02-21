module Api
  module V1
    module Users
      class FollowedPeopleNewsController < ExceptionsController
        authorize_resource class: :user_followed_people_news

        def index
          render json: { news: News.joins(:followed_people)
                                   .where(followed_people: { id: current_user.followed_person_ids }) }
        end
      end
    end
  end
end
