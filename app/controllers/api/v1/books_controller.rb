module Api
  module V1
    class BooksController < ApplicationController
      def index
        if params[:search]
          q = "%#{params[:search]}%"
          @books = Book.where("title ILIKE ? OR author ILIKE ?", q, q)
        else
          @books = Book.all
        end
        render json: @books
      end

      def show
        @book = Book.find(params[:id])
        render json: @book, include: :reviews
      end

      def create
        @book = Book.new(book_params)
        if @book.save
          render json: @book, status: :created
        else
          render json: @book.errors, status: :unprocessable_entity
        end
      end

      private

      def book_params
        params.require(:book).permit(:title, :author)
      end
    end
  end
end
