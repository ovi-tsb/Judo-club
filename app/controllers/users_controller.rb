class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @user = current_user
    @members = Member.all
    # @member = Member.find(params[:id])
    # authorize @member
    # @members = current_user.member
    # @users = User.all
    @users = User.all
    
    # if current_user.try(:type) == 'AdminUser'
    #   @user = User.all
    # else
    #   @user = current_user
    # end
    
    @filterrific = initialize_filterrific(
      # to have jobs_by(current_user) in filteriffic
      # Invoice.joins(:job).where(:jobs => {:user_id => current_user})
      # User.joins(:member),
      User.all,
      params[:filterrific],
      select_options: {
        # jobs_by: Job.jobs_by current_user ,
        sorted_by: User.options_for_sorted_by,
        with_status: User.options_for_select
      }
    ) or return
    @users = @filterrific.find.page(params[:page])

    respond_to do |format|
         format.html
         format.js
       end
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
                                  members_attributes: [:id, :first_name, :last_name, :birth_year,
                                  :status, :_destroy])
    end

    def set_user
      @user = User.find(params[:id])
    end
end
