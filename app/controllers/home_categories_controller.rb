class HomeCategoriesController < ApplicationController
  before_filter :authenticate_user!, :redirect_unless_admin, :generate_bread_crumbs
  
  # GET /home_categories
  # GET /home_categories.json
  def index
    @home_categories = HomeCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @home_categories }
    end
  end

  # GET /home_categories/1
  # GET /home_categories/1.json
  def show
    @home_category = HomeCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @home_category }
    end
  end

  # GET /home_categories/new
  # GET /home_categories/new.json
  def new
    @home_category = HomeCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @home_category }
    end
  end

  # GET /home_categories/1/edit
  def edit
    @home_category = HomeCategory.find(params[:id])
  end

  # POST /home_categories
  # POST /home_categories.json
  def create
    @home_category = HomeCategory.new(params[:home_category])

    respond_to do |format|
      if @home_category.save
        format.html { redirect_to @home_category, notice: 'Home category was successfully created.' }
        format.json { render json: @home_category, status: :created, location: @home_category }
      else
        format.html { render action: "new" }
        format.json { render json: @home_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /home_categories/1
  # PUT /home_categories/1.json
  def update
    @home_category = HomeCategory.find(params[:id])

    respond_to do |format|
      if @home_category.update_attributes(params[:home_category])
        format.html { redirect_to @home_category, notice: 'Home category was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @home_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /home_categories/1
  # DELETE /home_categories/1.json
  def destroy
    @home_category = HomeCategory.find(params[:id])
    @home_category.destroy

    respond_to do |format|
      format.html { redirect_to home_categories_url }
      format.json { head :ok }
    end
  end
  
  private
  
  def generate_bread_crumbs
    add_breadcrumb "Administrador", :administration_index_path
  end
  
end
