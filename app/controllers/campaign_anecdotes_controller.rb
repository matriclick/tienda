class CampaignAnecdotesController < ApplicationController
	before_filter :redirect_unless_admin
	
  # GET /campaign_anecdotes
  # GET /campaign_anecdotes.json
  def index
    @campaign_anecdotes = CampaignAnecdote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @campaign_anecdotes }
    end
  end

  # GET /campaign_anecdotes/new
  # GET /campaign_anecdotes/new.json
  def new
    @campaign_anecdote = CampaignAnecdote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @campaign_anecdote }
    end
  end

  # GET /campaign_anecdotes/1/edit
  def edit
    @campaign_anecdote = CampaignAnecdote.find(params[:id])
  end

  # POST /campaign_anecdotes
  # POST /campaign_anecdotes.json
  def create
    @campaign_anecdote = CampaignAnecdote.new(params[:campaign_anecdote])

    respond_to do |format|
      if @campaign_anecdote.save
        format.html { redirect_to anecdotes_url(@campaign_anecdote), notice: 'Campaign anecdote was successfully created.' }
        format.json { render json: @campaign_anecdote, status: :created, location: @campaign_anecdote }
      else
        format.html { render action: "new" }
        format.json { render json: @campaign_anecdote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /campaign_anecdotes/1
  # PUT /campaign_anecdotes/1.json
  def update
    @campaign_anecdote = CampaignAnecdote.find(params[:id])

    respond_to do |format|
      if @campaign_anecdote.update_attributes(params[:campaign_anecdote])
        format.html { redirect_to anecdotes_url(@campaign_anecdote), notice: 'Campaign anecdote was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @campaign_anecdote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaign_anecdotes/1
  # DELETE /campaign_anecdotes/1.json
  def destroy
    @campaign_anecdote = CampaignAnecdote.find(params[:id])
    @campaign_anecdote.destroy

    respond_to do |format|
      format.html { redirect_to campaign_anecdotes_url }
      format.json { head :ok }
    end
  end
end
