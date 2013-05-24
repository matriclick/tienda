class CampaignGalleryItemsController < ApplicationController
	before_filter :redirect_unless_admin
	
  # GET /campaign_gallery_items
  # GET /campaign_gallery_items.json
  def index
    @campaign_gallery_items = CampaignGalleryItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @campaign_gallery_items }
    end
  end

  # GET /campaign_gallery_items/new
  # GET /campaign_gallery_items/new.json
  def new
    @campaign_gallery_item = CampaignGalleryItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @campaign_gallery_item }
    end
  end

  # GET /campaign_gallery_items/1/edit
  def edit
    @campaign_gallery_item = CampaignGalleryItem.find(params[:id])
  end

  # POST /campaign_gallery_items
  # POST /campaign_gallery_items.json
  def create
    @campaign_gallery_item = CampaignGalleryItem.new(params[:campaign_gallery_item])

    respond_to do |format|
      if @campaign_gallery_item.save
        format.html { redirect_to supplier_gallery_path(@campaign_gallery_item), notice: 'Campaign gallery item was successfully created.' }
        format.json { render json: @campaign_gallery_item, status: :created, location: @campaign_gallery_item }
      else
        format.html { render action: "new" }
        format.json { render json: @campaign_gallery_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /campaign_gallery_items/1
  # PUT /campaign_gallery_items/1.json
  def update
    @campaign_gallery_item = CampaignGalleryItem.find(params[:id])

    respond_to do |format|
      if @campaign_gallery_item.update_attributes(params[:campaign_gallery_item])
        format.html { redirect_to supplier_gallery_path(@campaign_gallery_item), notice: 'Campaign gallery item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @campaign_gallery_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaign_gallery_items/1
  # DELETE /campaign_gallery_items/1.json
  def destroy
    @campaign_gallery_item = CampaignGalleryItem.find(params[:id])
    @campaign_gallery_item.destroy

    respond_to do |format|
      format.html { redirect_to campaign_gallery_items_url }
      format.json { head :ok }
    end
  end
end
