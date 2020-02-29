class MembersController < ApplicationController
  before_action :authorize_admin, only: :index
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def index
    @member = Member.all
    @member = Member.new
    
    @filterrific = initialize_filterrific(
      # to have jobs_by(current_user) in filteriffic
      # Invoice.joins(:job).where(:jobs => {:user_id => current_user})
      # User.joins(:member),
      Member.joins(:user),
      params[:filterrific],
      select_options: {
        # jobs_by: Job.jobs_by current_user ,
        sorted_by: Member.options_for_sorted_by,
        with_status: Member.options_for_select,
        with_pay_status: Member.options_for_select_2
      }
    ) or return
    @members = @filterrific.find.page(params[:page])

    respond_to do |format|
         format.html
         format.js
       end
  end

  def new
    @member = Member.new
  end

  def create
    # @member = Member.new(member_params)
    @member = current_user.members.build(params[:member])
    @member.user_id = current_user.id
    @member.user.first_name = current_user.first_name

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    
    respond_to do |format|
      if @member.update(member_params)
        if current_user.try(:type) != 'AdminUser'
          format.html { redirect_to members_path, notice: 'User was successfully updated.' } 
        else  
          format.html { redirect_to member_path, notice: 'User was successfully updated.' } 
        end
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @member = Member.where(:user_id => @member.user_id)
  end

  def destroy
  end

  def edit 
  end

private
  def set_member
    @member = Member.find(params[:id])
  end
  def member_params
    params.require(:member).permit( :first_name,
                                  :last_name,
                                  :birth_year,
                                  :user_id,
                                  :status,
                                  :pay_status
                                )
  end
end
