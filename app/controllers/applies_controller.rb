class AppliesController < ApplicationController
  before_action :set_post, only: [:create, :update, :destroy]
  before_action :authenticate_user

  def create
    @post.applies.create(user_id: @current_user.id, post_user_id: @post.user_id, state: "applied")
    redirect_to post_path(@post)
  end

  def update
    apply = Apply.find(params[:id])
    if params[:state] == "lose"
      apply.state = "lose"
      apply.save
    elsif params[:state] == "win"
      apply.state = "win"
      apply.save
      others = @post.applies.where(post_id: @post.id, state: "applied")

      others.each do |other|
        other.state = "lose"
        other.save
      end

    end
    redirect_to "/notes/#{@current_user.id}"
  end

  def destroy
    @apply = @post.applies.find_by(user_id: @current_user.id)
    @apply.destroy
    redirect_to post_path(@post)
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end
end
