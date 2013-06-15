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
    elsif numeric?(params[:u]) and (current_user.admin? or !current_supplier.nil?)
      @id = params[:u]
    else
      redirect_to root_country_path
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cloth_measure }
    end
  end

  # GET /cloth_measures/1/edit
  def edit
    @cloth_measure = ClothMeasure.find(params[:id])
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
          dress.update_attribute(:cloth_measure_id, @cloth_measure.id)
          format.html { redirect_to dress_ver_path(type: dress.dress_types.first.name, slug: dress.slug), notice: 'Cloth measure was successfully created.' }
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
          format.html { redirect_to dress_ver_path(type: @cloth_measure.dress.dress_types.first.name, slug: @cloth_measure.dress.slug), notice: 'Cloth measure was successfully updated.' }
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
