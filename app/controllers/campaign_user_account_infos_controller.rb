class CampaignUserAccountInfosController < ApplicationController
	before_filter :redirect_unless_admin
  # GET /campaign_user_account_infos
  # GET /campaign_user_account_infos.json
  def index
    @campaign_user_account_infos = CampaignUserAccountInfo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @campaign_user_account_infos }
    end
  end

  # GET /campaign_user_account_infos/1
  # GET /campaign_user_account_infos/1.json
  def show
    @campaign_user_account_info = CampaignUserAccountInfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @campaign_user_account_info }
    end
  end

  # GET /campaign_user_account_infos/new
  # GET /campaign_user_account_infos/new.json
  def new
    @campaign_user_account_info = CampaignUserAccountInfo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @campaign_user_account_info }
    end
  end

  # GET /campaign_user_account_infos/1/edit
  def edit
    @campaign_user_account_info = CampaignUserAccountInfo.find(params[:id])
  end

  # POST /campaign_user_account_infos
  # POST /campaign_user_account_infos.json
  def create
    @campaign_user_account_info = CampaignUserAccountInfo.new(params[:campaign_user_account_info])
    @campaign_user_account_info.user_account_id = current_user.user_account_id

    respond_to do |format|
      if @campaign_user_account_info.save
        format.html { redirect_to action: "index", notice: 'Campaign user account info was successfully created.' }
        format.json { render json: @campaign_user_account_info, status: :created, location: @campaign_user_account_info }
      else
        format.html { render action: "new" }
        format.json { render json: @campaign_user_account_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /campaign_user_account_infos/1
  # PUT /campaign_user_account_infos/1.json
  def update
    @campaign_user_account_info = CampaignUserAccountInfo.find(params[:id])

    respond_to do |format|
      if @campaign_user_account_info.update_attributes(params[:campaign_user_account_info])
        format.html { redirect_to action: "index", notice: 'Campaign user account info was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @campaign_user_account_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaign_user_account_infos/1
  # DELETE /campaign_user_account_infos/1.json
  def destroy
    @campaign_user_account_info = CampaignUserAccountInfo.find(params[:id])
    @campaign_user_account_info.destroy

    respond_to do |format|
      format.html { redirect_to campaign_user_account_infos_url }
      format.json { head :ok }
    end
  end
end
