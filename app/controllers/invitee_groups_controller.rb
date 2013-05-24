class InviteeGroupsController < ApplicationController
#before_filter :redirect_unless_user_signed_in
before_filter :authenticate_user!
before_filter :has_invitee_group, :only=>[:show,:edit,:update,:destroy]
before_filter :has_base_groups, :only=>[:show,:index]

  
	# GET /invitee_groups
  # GET /invitee_groups.json  
  def index
   @invitee_groups = InviteeGroup.where(:user_account_id => current_user.user_account.id)			
		
    respond_to do |format|
      format.html {render :layout=> false}# index.html.erb
      format.json { render json: @inviteegroups }
      format.js
		end
  end



  # GET /invitee_groups/1
  # GET /invitee_groups/1.json
  def show
    @invitee_group = InviteeGroup.find(params[:id])

    respond_to do |format|
      format.html { redirect_to invitee_groups_url }
      format.json { render json: @invitee_group }
			format.js
    end
  end


  # GET /invitee_groups/new
  # GET /invitee_groups/new.json
  def new
    @invitee_group = InviteeGroup.new
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invitee }
			format.js
    end
  end

  # GET /invitee_groups/1/edit
  def edit
    @invitee_group = InviteeGroup.find(params[:id])
  end

  # POST /invitee_groups
  # POST /invitee_groups
  def create
    @invitee_group = InviteeGroup.new(params[:invitee_group])
		@invitee_group.user_account = current_user.user_account

		@invitee_groups = InviteeGroup.where(:user_account_id => current_user.id)
		
    respond_to do |format|
      if @invitee_group.save
				@invitee_groups = InviteeGroup.where(:user_account_id => current_user.user_account.id)
        format.html { redirect_to invitee_groups_url, notice: 'Group was successfully created.' }
        format.json { render json: @invitee_group, status: :created, location: @invitee_group }
				format.js
      else
				format.html { render action: "new" }
        format.json { render json: @invitee_group.errors, status: :unprocessable_entity }
				format.js
      end
    end
  end

  # PUT /invitee_groups/1
  # PUT /invitee_groups/1.json
  def update
    @invitee_group = InviteeGroup.find(params[:id])

    respond_to do |format|
      if @invitee_group.update_attributes(params[:invitee_group])
        format.html { redirect_to invitee_groups_url, notice: 'Group was successfully updated.' }
        format.json { head :ok }
				format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @invitee_group.errors, status: :unprocessable_entity }
				format.js
      end
    end
  end

  # DELETE /invitee_groups/1
  # DELETE /invitee_groups/1.json
  def destroy
    @invitee_group = InviteeGroup.find(params[:id])
    @invitee_group.destroy

    respond_to do |format|
      format.html { redirect_to invitee_groups_url }
      format.json { head :ok }
			format.js
    end
  end 

	def has_invitee_group	
		unless InviteeGroup.exists?(params[:id]) && current_user.user_account.id == InviteeGroup.find(params[:id]).user_account_id
			redirect_to invitee_groups_path		
		end
	end

	def has_base_groups
		@user_account = current_user.user_account
		if !InviteeGroup.find_by_user_account_id(@user_account.id).present?
      @user_account.assign_default_invitee_groups
    end
	end

end
