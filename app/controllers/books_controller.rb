class BooksController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user

  def create
    @user = User.find(params[:user_id])
    @user.books.create(book_params)
    redirect_to edit_user_path(@user)
  end

  def destroy
    @user = User.find(params[:user_id])
    @book = @user.books.find(params[:id])
    @book.destroy
    redirect_to edit_user_path(@user)
  end

  private
    def book_params
      params.require(:book).permit(:title)
    end

    def ensure_correct_user
      if @current_user.id != params[:user_id].to_i
        flash[:notice] = "権限がありません"
        redirect_to posts_path
      end
    end
end
