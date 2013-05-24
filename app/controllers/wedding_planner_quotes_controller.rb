class WeddingPlannerQuotesController < ApplicationController
  before_filter :authenticate_user!, :except => [:welcome]
  before_filter :check_if_owner, :only => [:edit, :show]
      
  def welcome
    
  end
  
  # GET /wedding_planner_quotes
  # GET /wedding_planner_quotes.json
  def index
    redirect_unless_privilege('Salestool')
    
    @wedding_planner_quotes = WeddingPlannerQuote.all

  end

  # GET /wedding_planner_quotes/1
  # GET /wedding_planner_quotes/1.json
  def show
    @wedding_planner_quote = WeddingPlannerQuote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wedding_planner_quote }
    end
  end

  # GET /wedding_planner_quotes/new
  # GET /wedding_planner_quotes/new.json
  def new
    if !current_user.wedding_planner_quote.nil?
      redirect_to edit_wedding_planner_quote_path(current_user.wedding_planner_quote)
    else
      @wedding_planner_quote = WeddingPlannerQuote.new
    
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @wedding_planner_quote }
      end
    end
  end

  # GET /wedding_planner_quotes/1/edit
  def edit
    @wedding_planner_quote = WeddingPlannerQuote.find(params[:id])
  end

  # POST /wedding_planner_quotes
  # POST /wedding_planner_quotes.json
  def create
    @wedding_planner_quote = WeddingPlannerQuote.new(params[:wedding_planner_quote])
    
    respond_to do |format|
      if @wedding_planner_quote.save
        NoticeMailer.wedding_planner_email(@wedding_planner_quote, 'Nueva').deliver
        format.html { redirect_to @wedding_planner_quote, notice: 'Solicitud de Wedding Planner Ingresada' }
        format.json { render json: @wedding_planner_quote, status: :created, location: @wedding_planner_quote }
      else
        format.html { render action: "new" }
        format.json { render json: @wedding_planner_quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wedding_planner_quotes/1
  # PUT /wedding_planner_quotes/1.json
  def update
    @wedding_planner_quote = WeddingPlannerQuote.find(params[:id])

    respond_to do |format|
      if @wedding_planner_quote.update_attributes(params[:wedding_planner_quote])
        NoticeMailer.wedding_planner_email(@wedding_planner_quote, 'Se actualiza').deliver
        format.html { redirect_to @wedding_planner_quote, notice: 'Wedding planner quote was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @wedding_planner_quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wedding_planner_quotes/1
  # DELETE /wedding_planner_quotes/1.json
  def destroy
    @wedding_planner_quote = WeddingPlannerQuote.find(params[:id])
    @wedding_planner_quote.destroy

    respond_to do |format|
      format.html { redirect_to wedding_planner_quotes_url }
      format.json { head :ok }
    end
  end

  private
  
  def check_if_owner
    wpq = WeddingPlannerQuote.find(params[:id])
    if wpq.user_id != current_user.id and !current_user.admin?
      redirect_to wedding_planner_path()
    end
  end
  
end
