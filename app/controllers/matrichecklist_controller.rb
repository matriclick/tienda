class MatrichecklistController < ApplicationController
  before_filter :authenticate_user!, :check_guest_wedding_date, :check_wedding_date
  before_filter :authenticate_guest, :only => [:index]
  before_filter :redirect_if_guest, :only => [:edit, :add]
  	
  def check_wedding_date
		if current_user.user_account.nil? or !current_user.user_account.wedding_tentative_date.present?
		  redirect_to user_profile_path, :notice => "Debes agregar la fecha de tu matrimonio ver la lista de actividades"
		end
  end
  
  def check_guest_wedding_date
  	if current_user.role_id == 3
  		current_user.user_account.wedding_tentative_date = Date.today+1.year
  		current_user.user_account.save
  	end
  end
  
  def index
	  @user_account = current_user.user_account
  
	  #If it is the firs time entering this module, all default activities are asigned
	  if !Activity.find_by_user_account_id(@user_account.id).present?
	    @user_account.assign_default_activities
	  end
	  
    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end
  
  #GET
  def ganttchart 
    @activities = current_user.user_account.activities
    wedding_date = current_user.user_account.wedding_tentative_date
    
    @date_start = @activities.first.done_by_date - 1.week
    @date_end = wedding_date
    
    @days = (@date_end - @date_start).to_i / 7
  end
  
  #GET
  def reminders
    @activity = Activity.find(params[:id])
    @reminder = ActivityReminder.new()
    
    @all_reminders = @activity.activity_reminders
  end
  
  #POST
  def activate_reminder
    
    @activity_reminder = ActivityReminder.new(params[:activity_reminder])
    @activity_reminder.activity_id = params[:activity_id]
    
    respond_to do |format|
      if @activity_reminder.save
        format.html { redirect_to :action => "reminders", :id => params[:activity_id], :notice => 'Reminder was successfully created.' }
        format.json { render :json => @activity_reminder, :status => :created }
      else
        format.html { render :action => "reminders" }
        format.json { render :json => @activity_reminder.errors, :status => :unprocessable_entity }
      end
    end
  end

  #DELETE  
  def delete_reminder
    @activity_reminder = ActivityReminder.find(params[:id])
    activity_id = @activity_reminder.activity.id
    @activity_reminder.destroy

    respond_to do |format|
      format.html { redirect_to :action => "reminders", :id => activity_id }
      format.json { head :ok }
    end
  end
  
  #GET
  def edit
    @activity = Activity.find(params[:id])
    @url_form = matrichecklist_update_path(:id => @activity.id)
  end
  # PUT
  def update
    @activity = Activity.find(params[:id])
    @url_form = matrichecklist_update_path(:id => @activity.id)
        
    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to :action => "index", :notice => 'Activity was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  #GET
  def add
    @activity = Activity.new()
    @url_form = matrichecklist_create_path
    
    respond_to do |format|
      format.html {render :layout=> false}# addActivity.html.erb
      format.json { render :json => @activity }
      format.js
    end
  end
  # POST 
  def create
    @activity = Activity.new(params[:activity])
    @activity.user_account_id = current_user.user_account.id
    @url_form = matrichecklist_create_path
    
    respond_to do |format|
      if @activity.save
        format.html { redirect_to :action => "index", :notice => 'Activity was successfully created.' }
        format.json { render :json => @activity, :status => :created, :location => @activity }
      else
        format.html { render :action => "add" }
        format.json { render :json => @activity.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end
  
  # DELETE
  def delete
    @activity = Activity.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to :action => "index" }
      format.json { head :ok }
    end
  end
  
  #AJAX
  def done
		@activity = Activity.find params[:id]
		
		if @activity.done
			@activity.update_attributes(:done => false)
		else 
			@activity.update_attributes(:done => true)
		end
		
		respond_to do |format|
      format.html { redirect_to :action => "index" }
      format.json { head :ok }
    end
  end
  
  #GET
  def view_activity
     @activity = Activity.find params[:id]
  end
  
  def redirect_if_guest
  	if current_user.role_id == 3 
  		redirect_to :action => :index
  	end
  end
end
