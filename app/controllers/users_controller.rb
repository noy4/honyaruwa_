class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:edit, :update, :destroy]
  before_action :forbid_login_user, only: [:new, :create, :login_form, :login]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @posts_count = Post.where(user_id: params[:id]).count
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @posts_count = Post.where(user_id: params[:id]).count
    @user.books.build
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.image_name = "default_user.jpg"

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
        session[:user_id] = @user.id
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if save_params[:image]
      image = save_params[:image]
      @user.image_name = "#{@user.id}.jpg"
      File.binwrite(Rails.root.join("public", "user_images", @user.image_name), image.read)
    end
    respond_to do |format|
      if @user.update(save_params)
        format.html { redirect_to edit_user_path(@user), notice: '変更を保存しました' }
        format.json { render :edit, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(email: login_params[:email])
    if @user && @user.authenticate(login_params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to posts_path
    else
      @error_message = "メールアドレスまたはパスワードが違います"
      render "users/login_form"
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to posts_path
  end

  def notes
    @notes = Apply.where(post_user_id: params[:user_id], state: "applied")
            .or(Apply.where(user_id: params[:user_id], state: "win"))
            .or(Apply.where(user_id: params[:user_id], state: "lose"))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def login_params
      params.permit(:email, :password)
    end

    def save_params
      params.require(:user).permit(:image, :name, :word, :university, :campus, :memo, books_attributes: [:title])
    end

    def ensure_correct_user
      if @current_user.id != params[:id].to_i
        flash[:notice] = "権限がありません"
        redirect_to posts_path
      end
    end
end
