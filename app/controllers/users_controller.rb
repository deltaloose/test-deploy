class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  def show
  	@user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end
  def index
  	@users = User.all
    @book = Book.new
  end
  def edit
    if @user = current_user
    else
    render :show
    end
  end
  def update
  	@user = current_user
  	if @user.update(user_params)
        flash[:success] = 'You have updated user successfully.'
  		redirect_to user_path(@user.id)
  	else
  		render :edit
  	end
  end
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
