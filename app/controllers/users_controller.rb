class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.id == session[:user_id]
      @user.update(user_params)
      redirect_to user_path(current_user.id), notice: "プロフィール画像を編集しました！"
    elsif @user.id != session[:user_id]
      redirect_to pictures_path, notice: "その行為は禁止されています"
    else
      render 'edit', notice: @user.errors.full_messages
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end
end
