class IndustryCategoriesController < ApplicationController
  before_filter :redirect_unless_admin
  # GET /industry_categories
  # GET /industry_categories.json
  def index
    @industry_categories = IndustryCategory.joins(:countries).where("countries.id = ?", session[:country].id).order(:position)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @industry_categories }
    end
  end

  # GET /industry_categories/1
  # GET /industry_categories/1.json
  def show
    @industry_category = IndustryCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @industry_category }
    end
  end

  # GET /industry_categories/new
  # GET /industry_categories/new.json
  def new
    @industry_category = IndustryCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @industry_category }
    end
  end

  # GET /industry_categories/1/edit
  def edit
    @industry_category = IndustryCategory.find(params[:id])
  end

  # POST /industry_categories
  # POST /industry_categories.json
  def create
    @industry_category = IndustryCategory.new(params[:industry_category])

    respond_to do |format|
      if @industry_category.save
        format.html { redirect_to @industry_category, :notice => "#{t('activerecord.successful.messages.created', :model =>  @industry_category.class.model_name.human)}"  }
        format.json { render json: @industry_category, status: :created, location: @industry_category }
      else
        format.html { render action: "new" }
        format.json { render json: @industry_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /industry_categories/1
  # PUT /industry_categories/1.json
  def update
    @industry_category = IndustryCategory.find(params[:id])

    respond_to do |format|
      if @industry_category.update_attributes(params[:industry_category])
        format.html { redirect_to industry_categories_path, :notice => "#{t('activerecord.successful.messages.updated', :model =>  @industry_category.class.model_name.human)}"  }        
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @industry_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /industry_categories/1
  # DELETE /industry_categories/1.json
  def destroy
    @industry_category = IndustryCategory.find(params[:id])
    @industry_category.destroy

    respond_to do |format|
      format.html { redirect_to industry_categories_url }
      format.json { head :ok }
    end
  end
end
