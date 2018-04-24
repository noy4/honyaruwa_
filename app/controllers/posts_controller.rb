class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.search(params[:search])
    @search = params[:search]
    # if params[:search] || params[:subject]
    #   subject_ids = Post.where("subject = ?", params[:subject]) .pluck(:id)
    #   keyword_ids = Post.where("text_title LIKE (?)", "#{params[:search]}").pluck(:id)
    #   @posts = Post.where("id IN (?) or id IN (?)", subject_ids, keyword_ids)
    # else
    #   @posts = Post.all
    # end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @user = User.find_by(id: @post.user_id)

    if @current_user
      @apply = @post.applies.find_by(user_id: @current_user.id)
    end

    if @post.condition == "1"
      @condition = "新品、未使用"
    elsif @post.condition == "2"
      @condition = "未使用に近い"
    elsif @post.condition == "3"
      @condition = "汚い"
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = @current_user.id
    @post.save
    image = post_params[:image]
    @post.image_name = "#{@post.id}.jpg"

    respond_to do |format|
      if @post.save

        File.binwrite(Rails.root.join("public", "text_images", @post.image_name), image.read)
        format.html { redirect_to @post, notice: '投稿しました' }
        format.json { render :show, status: :created, location: @post }
      else
        @post.destroy
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if post_params[:image]
      image = post_params[:image]
      File.binwrite(Rails.root.join("public", "text_images", @post.image_name), image.read)
    end

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: '投稿を更新しました' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    File.delete(Rails.root.join("public", "text_images", @post.image_name))
    respond_to do |format|
      format.html { redirect_to posts_url, notice: '投稿を削除しました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:image, :text_title, :text_about, :subject, :condition, :price, :place)
    end

    def ensure_correct_user
      if @current_user.id != @post.user_id
        flash[:notice] = "権限がありません"
        redirect_to posts_path
      end
    end

end
