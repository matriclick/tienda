# encoding: UTF-8
class ContestantsController < ApplicationController
  autocomplete :user, :email
  before_filter :redirect_unless_admin, :generate_bread_crumbs, :except => [:show, :add_vote]
  before_filter :authenticate_user!, :only => [:add_vote]
    
  def add_vote
    @contestant = Contestant.find(params[:id])
    
    @cv = ContestVote.find_or_create_by_contest_id_and_user_id(@contestant.contest.id, current_user.id)
    @cv.contestant_id = @contestant.id
    @cv.save
    
    redirect_to contest_path(@contestant.contest), notice: '¡Felicitaciones! Votaste por '+@contestant.name.capitalize
  end
  
  # GET /contestants
  # GET /contestants.json
  def index
    contest = Contest.find(params[:contest_id]) if !params[:contest_id].nil?
    if contest.nil?
      @contestants = Contestant.all
    else
      @contestants = contest.contestants
    end

    @contestants.sort_by{|c| c.contest_votes.size}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contestants }
    end
  end

  # GET /contestants/1
  # GET /contestants/1.json
  def show
    @contestant = Contestant.find(params[:id])

    add_breadcrumb "Tramanta", :root_path
    add_breadcrumb @contestant.contest.name.capitalize, @contestant.contest
    add_breadcrumb @contestant.name.capitalize, @contestant
    
    @title_content = @contestant.name
  	@meta_description_content = @contestant.introduction
    @og_type = 'article'
    @og_image = 'http://www.tramanta.com'+@contestant.contestant_images.first.image.url(:main)
    @og_description = @contestant.name+' - '+@contestant.introduction

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contestant }
    end
  end

  # GET /contestants/new
  # GET /contestants/new.json
  def new
    @contestant = Contestant.new
    @contest = Contest.find params[:contest_id]
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contestant }
    end
  end

  # GET /contestants/1/edit
  def edit
    @contestant = Contestant.find(params[:id])
    
    @contest = @contestant.contest
    
  end

  # POST /contestants
  # POST /contestants.json
  def create
    @contestant = Contestant.new(params[:contestant])
    user = User.find_by_email(params[:user_email])
    @contestant.user = user if !user.nil?

    respond_to do |format|
      if @contestant.save
        format.html { redirect_to @contestant, notice: 'Contestant was successfully created.' }
        format.json { render json: @contestant, status: :created, location: @contestant }
      else
        format.html { render action: "new" }
        format.json { render json: @contestant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contestants/1
  # PUT /contestants/1.json
  def update
    @contestant = Contestant.find(params[:id])
    user = User.find_by_email(params[:user_email])
    @contestant.user = user if !user.nil?

    respond_to do |format|
      if @contestant.update_attributes(params[:contestant])
        format.html { redirect_to @contestant, notice: 'Contestant was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @contestant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contestants/1
  # DELETE /contestants/1.json
  def destroy
    @contestant = Contestant.find(params[:id])
    @contestant.destroy

    respond_to do |format|
      format.html { redirect_to contestants_url }
      format.json { head :ok }
    end
  end
  
  private
  
  def generate_bread_crumbs
    add_breadcrumb "Administrador", :administration_index_path
    add_breadcrumb "Competencias", :contests_path
  end
end
