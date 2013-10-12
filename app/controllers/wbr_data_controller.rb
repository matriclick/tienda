class WbrDataController < ApplicationController
  before_filter :redirect_unless_admin, :generate_bread_crumbs
  # GET /wbr_data
  # GET /wbr_data.json
  def index
    @wbr_data = WbrDatum.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @wbr_data }
    end
  end

  # GET /wbr_data/1
  # GET /wbr_data/1.json
  def show
    @wbr_datum = WbrDatum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wbr_datum }
    end
  end

  # GET /wbr_data/new
  # GET /wbr_data/new.json
  def new
    @wbr_datum = WbrDatum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wbr_datum }
    end
  end

  # GET /wbr_data/1/edit
  def edit
    @wbr_datum = WbrDatum.find(params[:id])
  end

  # POST /wbr_data
  # POST /wbr_data.json
  def create
    @wbr_datum = WbrDatum.new(params[:wbr_datum])

    respond_to do |format|
      if @wbr_datum.save
        format.html { redirect_to wbr_data_path, notice: 'Wbr datum was successfully created.' }
        format.json { render json: @wbr_datum, status: :created, location: @wbr_datum }
      else
        format.html { render action: "new" }
        format.json { render json: @wbr_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wbr_data/1
  # PUT /wbr_data/1.json
  def update
    @wbr_datum = WbrDatum.find(params[:id])

    respond_to do |format|
      if @wbr_datum.update_attributes(params[:wbr_datum])
        format.html { redirect_to wbr_data_path, notice: 'Wbr datum was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @wbr_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wbr_data/1
  # DELETE /wbr_data/1.json
  def destroy
    @wbr_datum = WbrDatum.find(params[:id])
    @wbr_datum.destroy

    respond_to do |format|
      format.html { redirect_to wbr_data_url }
      format.json { head :ok }
    end
  end
  
  private
  
  def generate_bread_crumbs
    add_breadcrumb "Administrador", :administration_index_path
    add_breadcrumb "WBR", :reports_wbr_path
  end
  
end
