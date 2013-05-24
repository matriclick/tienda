class SchedulesController < ApplicationController
  before_filter :check_supplier, :set_supplier_layout, :find_supplier
	
  def index
    @service = Service.find params[:service_id]
    @schedule = @service.schedule
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schedules }
    end
  end

  def show
    @service = Service.find params[:service_id]
    @schedule = @service.schedule
    @day = Day.all    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @schedule }
    end
  end

  def new
    @schedule = Schedule.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @schedule }
    end
  end

  def edit
    @days = Day.all
    @service = Service.find params[:service_id]    
    @schedule = @service.schedule
    @cont = 0
    @i =@schedule.days.first.id    
  end

  def create
    @schedule = Schedule.create(params[:schedule])

    respond_to do |format|
      if @schedule.save
				@supplier.supplier_account.schedules << @schedule
        format.html { redirect_to supplier_account_schedules_url(@supplier), :notice => "#{t('activerecord.successful.messages.created', :model => @schedule.class.model_name.human)}" }
        format.json { render json: @schedule, status: :created, location: @schedule }
      else
        format.html { render action: "new" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @schedule = Schedule.find params[:id]
    if params[:schedule_day_types][:schedule_day_type_id].blank? #DZF Update by Usual way
    	respond_to do |format|
      if @schedule.update_attributes params[:schedule]
        #[2011/08/24 DZF] this loop is for set all_day false when the day is not enabled AND clear hours if all_day is enabled
        @cont = @schedule.schedule_days.first.id
        while @cont < @schedule.schedule_days.first.id+7 do
          if @schedule.schedule_days.find(@cont).enabled == true
            if @schedule.schedule_days.find(@cont).all_day == false
              #do nothing, just save
            else
              @schedule.schedule_days.find(@cont).update_attributes(:from => '')
              @schedule.schedule_days.find(@cont).update_attributes(:to => '')
            end
          else
              @schedule.schedule_days.find(@cont).update_attributes(:all_day => false)
              @schedule.schedule_days.find(@cont).update_attributes(:from => '')
              @schedule.schedule_days.find(@cont).update_attributes(:to => '')
          end
          @cont = @cont +1
        end
        @cont = nil
        format.html { redirect_to supplier_account_service_schedule_path(@supplier, params[:service_id], @schedule), :notice => "#{t('activerecord.successful.messages.updated', :model => @schedule.class.model_name.human)}" }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
    else #DZF Update by schedule_day_types select
			@schedule_day_types = ScheduleDayType.find params[:schedule_day_types][:schedule_day_type_id]
			@cont = @schedule.schedule_days.first.id
			while @cont < @schedule.schedule_days.first.id+7 do
				@schedule_day_types.schedule_days.each do |sd|
					if sd.day_id == @schedule.schedule_days.find(@cont).day_id
						@schedule.schedule_days.find(@cont).update_attributes(:enabled => sd.enabled, :from => sd.from, :to => sd.to, :start_lunch_time => sd.start_lunch_time, :end_lunch_time => sd.end_lunch_time)
					end
				end
			@cont = @cont +1
			end
			
			respond_to do |format|
		    format.html { redirect_to :back }
		    format.json { head :ok }
		  end
    end
  end

  def destroy
    @schedule = @supplier.supplier_account.schedules.find params[:id]
    @schedule.destroy

    respond_to do |format|
      format.html { redirect_to supplier_account_schedules_url(@supplier) }
      format.json { head :ok }
    end
  end
end
