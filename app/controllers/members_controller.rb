class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def index

  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
    @member.user_id = current_user.id

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
      if @member.update(user_params)
        # if current_user&.subscribed?
          format.html { redirect_to members_path, notice: 'User was successfully updated.' } 
        # else  
          # format.html { redirect_to edit_user_registration_path, notice: 'User was successfully updated.' } 
        # end
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def destroy
    
  end

private
  def set_member
    @member = Member.find(params[:id])
  end
  def member_params
    params.require(:member).permit( :first_name,
                                  :last_name,
                                  :birth_year,
                                  :user_id 
                                )
  end
end
