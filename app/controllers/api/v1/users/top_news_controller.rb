module Api
  module V1
    module Users
      class TopNewsController < ExceptionsController
        authorize_resource class: :user_top_news

        def index
          sorted_news = News.where(category_id: current_user.category_ids).to_a.sort
          news = sorted_news[0..9]
          render json: { news: news }
        end

        def default_serializer_options
          { root: false }
        end
      end
    end
  end
end
