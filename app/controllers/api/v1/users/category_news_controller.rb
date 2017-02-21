module Api
  module V1
    module Users
      class CategoryNewsController < ExceptionsController
        authorize_resource class: :user_category_news

        def index
          news = { news: News.where(category_id: current_user.category_ids) }
          render json: news
        end

        def default_serializer_options
          { root: false }
        end
      end
    end
  end
end
