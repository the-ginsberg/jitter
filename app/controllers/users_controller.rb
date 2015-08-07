class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :help]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)    # Not the final implementation!
    if @user.save
      @user.send_activation_email

      personal = 'vBso0mRNZDCRNFcvriCDy1mZ6ssdMNeV6NoNK8U9'
      client = HipChat::Client.new(personal, :api_version => 'v2')
      client["WynHooked"].send("@TheGinsberg", "A new user has signed up for WynHooked!", :notify => true)

      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def help
    personal = 'vBso0mRNZDCRNFcvriCDy1mZ6ssdMNeV6NoNK8U9'
    client = HipChat::Client.new(personal, :api_version => 'v2')
    client["WynHooked"].send("@TheGinsberg", "@all A classmate is hooked bad and in need of immediate assistance!.", :notify => true)
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
