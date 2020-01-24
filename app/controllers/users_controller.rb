class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def edit
  end

  private
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
