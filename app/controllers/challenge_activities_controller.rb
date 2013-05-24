class ChallengeActivitiesController < ApplicationController
  before_filter :redirect_unless_admin, :hide_left_menu
  
  # GET /challenge_activities
  # GET /challenge_activities.json
  def index
    @challenge_activities = ChallengeActivity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @challenge_activities }
    end
  end
  
  # GET /challenge_activities/1
  # GET /challenge_activities/1.json
  def show
    @challenge_activity = ChallengeActivity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @challenge_activity }
    end
  end
  
  # GET /challenge_activities/new
  # GET /challenge_activities/new.json
  def new
    @challenge_activity = ChallengeActivity.new
    @challenge = Challenge.find(params[:challenge_id])
    @matriclicker = current_user.matriclicker
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @challenge_activity }
    end
  end

  # GET /challenge_activities/1/edit
  def edit
    redirect_unless_privilege('Tecnologia')
    @challenge_activity = ChallengeActivity.find(params[:id])
    @challenge = @challenge_activity.challenge
    @matriclicker = @challenge_activity.matriclicker
    
  end

  # POST /challenge_activities
  # POST /challenge_activities.json
  def create
    @challenge_activity = ChallengeActivity.new(params[:challenge_activity])

    respond_to do |format|
      if @challenge_activity.save
        format.html { redirect_to @challenge_activity.challenge.lead, notice: 'Challenge activity was successfully created.' }
        format.json { render json: @challenge_activity, status: :created, location: @challenge_activity }
      else
        format.html { render action: "new" }
        format.json { render json: @challenge_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /challenge_activities/1
  # PUT /challenge_activities/1.json
  def update
    @challenge_activity = ChallengeActivity.find(params[:id])

    respond_to do |format|
      if @challenge_activity.update_attributes(params[:challenge_activity])
        format.html { redirect_to @challenge_activity.challenge.lead, notice: 'Challenge activity was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @challenge_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenge_activities/1
  # DELETE /challenge_activities/1.json
  def destroy
    @challenge_activity = ChallengeActivity.find(params[:id])
    @challenge_activity.destroy

    respond_to do |format|
      format.html { redirect_to @challenge_activity.challenge.lead, notice: 'Challenge activity was successfully detroyed.' }
      format.json { head :ok }
    end
  end
end
