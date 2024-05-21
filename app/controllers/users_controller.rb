class UsersController < ApplicationController
 # ここから追加
 before_action :is_matching_login_user, only: [:edit, :update]
 # ここまで追加
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
    # ここから追加
  user = User.find(params[:id])
  unless user.id == current_user.id
    redirect_to post_books_path
  end
 # ここまで追加
    @user = User.find(params[:id])
 end
  def update
   
     # ここから追加
  user = User.find(params[:id])
  unless user.id == current_user.id
    redirect_to post_images_path
  end
  # ここまで追加

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
    # ここから追加
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end
  end
  # ここまで追加
end