class UsersController < ApplicationController
  before_action :authenticate_user!

  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    today = Date.today
    yesterday = today-1
    @today_book = @books.where("created_at >= ?",today)
    @yesterday_book = @books.where("created_at >= ?",yester)
  end

  def index
     @user =  current_user
    @users = User.all
    @book = Book.new
  end  

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end
  
  
  def follows
    user = User.find(params[:id])
    @users = user.followings
  end
  
   def followers
    user = User.find(params[:id])
    @users = user.followers
   end
  

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
