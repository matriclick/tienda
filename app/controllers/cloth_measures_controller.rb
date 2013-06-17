# encoding: UTF-8
class ClothMeasuresController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /cloth_measures
  # GET /cloth_measures.json
  def index
    @cloth_measures = ClothMeasure.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cloth_measures }
    end
  end

  # GET /cloth_measures/1
  # GET /cloth_measures/1.json
  def show
    @cloth_measure = ClothMeasure.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cloth_measure }
    end
  end

  # GET /cloth_measures/new
  # GET /cloth_measures/new.json
  def new
    @cloth_measure = ClothMeasure.new
    if params[:u] == 'ok'
      @id = 'current_user'
      add_breadcrumb 'Tu cuenta', user_profile_personalization_path
      add_breadcrumb 'Personalización', user_profile_personalization_path
      add_breadcrumb 'Agregar Medidas', new_cloth_measure_path
      
    elsif numeric?(params[:u]) and (current_user.admin? or !current_supplier.nil?)
      @id = params[:u]
      @size = Size.find(params[:size_id])
    else
      redirect_to root_country_path
    end
    
    respond_to do |format|
      if @id == params[:u]
        format.html { render :layout => false }
      else
        format.html
      end
      format.json { render json: @cloth_measure }
    end
  end

  # GET /cloth_measures/1/edit
  def edit
    @cloth_measure = ClothMeasure.find(params[:id])
    
    if !@cloth_measure.size.nil?
      @size = @cloth_measure.size
      @is_dress = true
    else
      add_breadcrumb 'Tu cuenta', user_profile_personalization_path
      add_breadcrumb 'Personalización', user_profile_personalization_path
      add_breadcrumb 'Editar Medidas', edit_cloth_measure_path(@cloth_measure)
      
      @is_dress = false
      @id = 'current_user'
    end
    
    respond_to do |format|
      if @is_dress
        format.html { render :layout => false }
      else
        format.html
      end
      format.json { render json: @cloth_measure }
    end
    
  end

  # POST /cloth_measures
  # POST /cloth_measures.json
  def create
    @cloth_measure = ClothMeasure.new(params[:cloth_measure])
    respond_to do |format|
      if @cloth_measure.save
        if params[:id] == 'current_user'
          current_user.update_attribute(:cloth_measure_id, @cloth_measure.id)
          format.html { redirect_to user_profile_personalization_path, notice: 'Cloth measure was successfully created.' }
          format.json { render json: @cloth_measure, status: :created, location: @cloth_measure }
        elsif numeric?(params[:id]) and (current_user.admin? or !current_supplier.nil?)
          dress = Dress.find(params[:id])
          dress.cloth_measures << @cloth_measure
          format.html { redirect_to dresses_set_stock_path(id: dress.id), notice: 'Cloth measure was successfully created.' }
          format.json { render json: @cloth_measure, status: :created, location: @cloth_measure }
        else
          format.html { render action: "new" }
          format.json { render json: @cloth_measure.errors, status: :unprocessable_entity }  
        end
      else
        format.html { render action: "new" }
        format.json { render json: @cloth_measure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cloth_measures/1
  # PUT /cloth_measures/1.json
  def update
    @cloth_measure = ClothMeasure.find(params[:id])

    respond_to do |format|
      if @cloth_measure.update_attributes(params[:cloth_measure])
        if !@cloth_measure.user.nil?
          format.html { redirect_to user_profile_personalization_path, notice: 'Cloth measure was successfully updated.' }
          format.json { head :ok }
        elsif !@cloth_measure.dress.nil?
          format.html { redirect_to dresses_set_stock_path(id: @cloth_measure.dress.id), notice: 'Cloth measure was successfully updated.' }
          format.json { head :ok }
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @cloth_measure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cloth_measures/1
  # DELETE /cloth_measures/1.json
  def destroy
    @cloth_measure = ClothMeasure.find(params[:id])
    @cloth_measure.destroy

    respond_to do |format|
      format.html { redirect_to cloth_measures_url }
      format.json { head :ok }
    end
  end
end
