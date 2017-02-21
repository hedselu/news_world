module Api
  module V1
    class VotesController < ExceptionsController
      before_action :set_news, only: :update
      authorize_resource

      def create
        @vote = Vote.new(vote_params)
        if @vote.save
          render json: { success: true }
        else
          render json: { errors: @vote.errors }, status: 422
        end
      end

      def update
        if @vote.update(value: vote_params[:value])
          render json: { success: true }
        else
          render json: { errors: @vote.errors }, status: 422
        end
      end

      private

      def set_news
        @vote = Vote.where('user_id=? AND news_id=?', vote_params[:user_id], vote_params[:news_id]).first
      end

      def vote_params
        params.require(:vote).permit(:value).merge(user_id: current_user.id, news_id: params[:news_id])
      end
    end
  end
end
