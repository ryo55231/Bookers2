class UsersController < ApplicationController
 # ここからユーザー制御
 before_action :is_matching_login_user, only: [:edit, :update]
 # ここまで
 def index
    @users = User.all
    @user = current_user
    @book = Book.new
 end
 def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
 end

 def edit
    # ここからユーザー制御
  user = User.find(params[:id])
  unless user.id == current_user.id
    redirect_to books_path
  end
 # ここまで
    @user = User.find(params[:id])
 end
  def update

     # ここからユーザー制御
  user = User.find(params[:id])
  unless user.id == current_user.id
    redirect_to books_path
  end
  # ここまで

   @user = User.find(params[:id])
  if  @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
  else
    @users = User.all
    render :edit
  end
  end

 private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
    # ここからユーザー制御
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
  # ここまで
end