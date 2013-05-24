class MatriclickersController < ApplicationController
  before_filter :redirect_unless_admin, :hide_left_menu
  before_filter { redirect_unless_privilege('Matriclickers') }
  
  # GET /matriclickers
  # GET /matriclickers.json
  def index
    @matriclickers = Matriclicker.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @matriclickers }
    end
  end

  # GET /matriclickers/1
  # GET /matriclickers/1.json
  def show
    @matriclicker = Matriclicker.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @matriclicker }
    end
  end

  # GET /matriclickers/new
  # GET /matriclickers/new.json
  def new
    @matriclicker = Matriclicker.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @matriclicker }
    end
  end

  # GET /matriclickers/1/edit
  def edit
    @matriclicker = Matriclicker.find(params[:id])
    
  end

  # POST /matriclickers
  # POST /matriclickers.json
  def create  
    @matriclicker = Matriclicker.new(params[:matriclicker])
        
    respond_to do |format|
      if @matriclicker.save
        format.html { redirect_to @matriclicker, notice: 'Matriclicker was successfully created.' }
        format.json { render json: @matriclicker, status: :created, location: @matriclicker }
      else
        format.html { render action: "new" }
        format.json { render json: @matriclicker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /matriclickers/1
  # PUT /matriclickers/1.json
  def update
    @matriclicker = Matriclicker.find(params[:id])

    respond_to do |format|
      if @matriclicker.update_attributes(params[:matriclicker])
        format.html { redirect_to @matriclicker, notice: 'Matriclicker was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @matriclicker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matriclickers/1
  # DELETE /matriclickers/1.json
  def destroy
    @matriclicker = Matriclicker.find(params[:id])
    @matriclicker.destroy

    respond_to do |format|
      format.html { redirect_to matriclickers_url }
      format.json { head :ok }
    end
  end
end
