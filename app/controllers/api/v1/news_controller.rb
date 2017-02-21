module Api
  module V1
    class NewsController < ExceptionsController
      before_action :set_news, except: :index
      authorize_resource

      def index
        @news = News.all
        render json: @news
      end

      def show
        if @news
          render json: @news
        else
          render json: { error: 'Not found' }, status: 404
        end
      end

      def destroy
        @news.try(:destroy)
        if @news.try(:destroy)
          render json: { success: true }
        else
          render json: { error: 'Not found' }, status: 404
        end
      end

      private

      def set_news
        @news = News.find(params[:id])
      end
    end
  end
end
