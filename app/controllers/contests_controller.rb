# encoding: UTF-8
class ContestsController < ApplicationController
  before_filter :redirect_unless_admin, :generate_bread_crumbs, :except => [:show]
  # GET /contests
  # GET /contests.json
  def index
    @contests = Contest.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contests }
    end
  end

  # GET /contests/1
  # GET /contests/1.json
  def show
    @contest = Contest.find(params[:id])
    
    add_breadcrumb "Tramanta", :root_path
    add_breadcrumb @contest.name.capitalize, @contest

    @title_content = @contest.name
  	@meta_description_content = @contest.instructions
    @og_type = 'article'
    @og_image = 'http://www.tramanta.com'+@contest.image.url(:xl)
    @og_description = @contest.name+' - '+@contest.instructions

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contest }
    end
  end

  # GET /contests/new
  # GET /contests/new.json
  def new
    add_breadcrumb "nueva", :new_contest_path
    @contest = Contest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contest }
    end
  end

  # GET /contests/1/edit
  def edit
    @contest = Contest.find(params[:id])
    add_breadcrumb "editar", edit_contest_path(id: params[:id])
  end

  # POST /contests
  # POST /contests.json
  def create
    @contest = Contest.new(params[:contest])

    respond_to do |format|
      if @contest.save
        format.html { redirect_to @contest, notice: 'Contest was successfully created.' }
        format.json { render json: @contest, status: :created, location: @contest }
      else
        format.html { render action: "new" }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contests/1
  # PUT /contests/1.json
  def update
    @contest = Contest.find(params[:id])

    respond_to do |format|
      if @contest.update_attributes(params[:contest])
        format.html { redirect_to @contest, notice: 'Contest was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contests/1
  # DELETE /contests/1.json
  def destroy
    @contest = Contest.find(params[:id])
    @contest.destroy

    respond_to do |format|
      format.html { redirect_to contests_url }
      format.json { head :ok }
    end
  end
  
  private
  
  def generate_bread_crumbs
    add_breadcrumb "Administrador", :administration_index_path
    add_breadcrumb "Competencias", :contests_path
  end
  
end
