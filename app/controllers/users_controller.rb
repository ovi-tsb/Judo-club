class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @user = current_user
    # @member = Member.find(params[:id])
    # authorize @member
    # @members = current_user.member
  end

  def show
    @member = Member.find(params[:id])
    authorize @member
    @members = current_user.member
    
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
  end

  def update
    respond_to do |format|
          if @user.update(user_params)
            # if current_user&.subscribed?
              format.html { redirect_to users_path, notice: 'User was successfully updated.' } 
            # else  
              # format.html { redirect_to edit_user_registration_path, notice: 'User was successfully updated.' } 
            # end
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
                                  members_attributes: [:id, :first_name, :last_name, :birth_year, :_destroy])
    end

    def set_user
      @user = User.find(params[:id])
    end
end
