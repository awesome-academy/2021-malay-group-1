class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create, :show]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find_by(id: params[:id])
    @course = Course.find_by(id: params[:course_id])
    @register = Register.new
    @review = Review.new
    @ids = current_user.course_ids

    unless @user
      flash[:danger] = t(:user_not_found)
      redirect_to home_path
    end
  end

  def new
     @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t(:check)
      redirect_to home_url
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = t("Profile updated")
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user&.destroy
      flash[:success] = t("User deleted")
    else
      flash[:danger] = t("Delete fail!")
    end
    redirect_to users_url
  end


  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t(:Please_log_in)
      redirect_to login_url
    end
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    return if current_user?(@user)
    flash[:danger] = t("not_authorized")
    redirect_to(home_url)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
