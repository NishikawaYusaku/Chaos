class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: %i[edit_email update_email edit_name update_name]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
      flash[:success] = "ユーザーを登録しました"
    else
      flash.now[:danger] = "ユーザーを登録できませんでした"
      render :new
    end
  end

  def show
    @vtuber = current_user.favorite_vtubers
  end

  def edit_email
    @user.email = ""
  end

  def update_email
    if @user.update(user_params)
      redirect_to user_path
      flash[:success] = "メールアドレスを変更しました"
    else
      flash.now[:danger] = "メールアドレスを変更できませんでした"
      render :edit_name
    end
  end

  def edit_name
    @user.name = ""
  end

  def update_name
    if @user.update(user_params)
      redirect_to user_path
      flash[:success] = "ユーザー名を変更しました"
    else
      flash.now[:danger] = "ユーザーを変更できませんでした"
      render :edit_name
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :agreement)
  end
end
