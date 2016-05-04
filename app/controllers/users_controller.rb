class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  def index
    #@users = User.all
    @users =User.paginate(page:params[:page], per_page: 5)
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id]= @user.id
      flash[:success] = "Welcome to the blog #{@user.username}"
      redirect_to articles_path(@user)
    else
      render 'new'
    end
  end
  def edit

  end
  def update

    if @user.update(user_params)
      flash[:success] = "Update successfully"
      redirect_to articles_path
    else
      render 'edit'
    end
  end
  def show
    @user_articles = @user.articles.paginate(page:params[:page], per_page:5)
  end
  def destroy
    @user.destroy
    flash[:danger] = "User and all articles related to this user have been destroy"
    redirect_to users_path
  end


  private
    def set_user
      @user = User.find(params[:id])
    end
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
    def require_same_user
      if current_user != @user and !current_user.admin?
        flash[:danger] = "You can only edit you profile"
        redirect_to articles_path
      end
    end
    def require_admin
      if logged_in? and !current_user.admin?
        flash[:danger] = "Only Admin can do that"
        redirect_to root_path
      end
    end
end
