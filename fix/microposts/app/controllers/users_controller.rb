class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show]
  
  def show # 追加
   @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
       redirect_to @user 
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:info] = 'Profileを更新しました。'
      redirect_to @user
    else
      flash[:danger] = 'Profileの更新に失敗しました。'
      render 'edit'
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :area, :password,
                                 :password_confirmation)
  end
      # beforeフィルター

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    
end
