class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @user = current_user
    @members = Member.all
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @member = Member.find(params[:id])
    authorize @member
    @members = Member.all
    # @member = Member.all
    @user = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name,
                                  members_attributes: [:id, :first_name, :last_name, :birth_year,
                                  :status, :_destroy])
    end

    def set_user
      @user = User.find(params[:id])
    end
end
