class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @user = @users.first
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    
    @books = @user.books
    @book = Book.new
  end

  def edit
  @user = User.find(params[:id])
  if @user == current_user
    render :edit
  else
    redirect_to user_path(current_user)
    
  end
end


  def update
    @user = User.find(params[:id])
    if @user == current_user
      if @user.update(user_params)
        redirect_to user_path(@user), notice: 'Profile was successfully updated'
      else
        render :edit
      end
    else
      redirect_to users_path(@user), alert: "You are not authorized to edit this profile."
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
