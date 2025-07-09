module Api
  module V1
    class ReviewsController < ApplicationController
      def index
        @book = Book.find(params[:book_id])
        render json: @book.reviews
      end

      def create
        @book = Book.find(params[:book_id])
        @review = @book.reviews.new(review_params.merge(user_id: 2))  # Replace user_id as needed
        if @review.save
          render json: @review, status: :created
        else
          render json: @review.errors, status: :unprocessable_entity
        end
      end

      private

      def review_params
        params.require(:review).permit(:content, :rating)
      end
    end
  end
end
