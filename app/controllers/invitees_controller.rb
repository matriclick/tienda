class InviteesController < ApplicationController
#before_filter :redirect_unless_user_signed_in
before_filter :has_invitee, :only=>[:show,:edit,:update,:destroy]
before_filter :authenticate_user!
before_filter :authenticate_guest, :only => [:menu]
before_filter :redirect_if_guest, :only => [:new, :edit, :create, :update]
  # GET /invitees
  # GET /invitees.json
  helper_method :sort_column,:sort_direction
  def index
    @invitees = Invitee.where(:user_account_id => current_user.user_account.id).search(params[:search]).order(sort_column+' '+sort_direction).paginate(:per_page => 20, :page=> params[:page])
		
		unless(params[:new_confirmed].nil?)
			inv = Invitee.find_by_id(params[:new_confirmed])			
			inv.confirmed ? inv.confirmed=false : inv.confirmed=true
			inv.save
		end
		
		@user_account = current_user.user_account
		unless InviteeGroup.find_by_user_account_id(@user_account.id).present?
      @user_account.assign_default_invitee_groups
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invitees }
      format.js
    end
  end

  # GET /invitees/1
  # GET /invitees/1.json
  def show
    @invitee = Invitee.find(params[:id])

    respond_to do |format|
      format.html { redirect_to invitees_url }
      format.json { render json: @invitee }
    end
  end

  # GET /invitees/new
  # GET /invitees/new.json
  def new
    @invitee = Invitee.new
    @age = Age.all
    @gender = Gender.all
    @status = Status.all
    @couple = Couple.all
		@hosts = InviteeHost.all
    @inviteegroup = InviteeGroup.where(:user_account_id => current_user.user_account.id)

    respond_to do |format|
      format.html { render :layout=> false }  # new.html.erb
      format.json { render json: @invitee }
			format.js
    end
  end

  # GET /invitees/1/edit
  def edit
    @invitee = Invitee.find(params[:id])
    @address = @invitee.address
    @age = Age.all
    @gender = Gender.all
    @status = Status.all
    @couple = Couple.all
		@hosts = InviteeHost.all
    @inviteegroup = InviteeGroup.where(:user_account_id => current_user.user_account.id)
		
		respond_to do |format|
      format.html { render :layout=> false }  # new.html.erb
      format.json { render json: @invitee }
			format.js
    end

  end

  # POST /invitees
  # POST /invitees.json
  def create
    @invitee = Invitee.new(params[:invitee])
		@invitee.user_account = current_user.user_account
    respond_to do |format|
      if @invitee.save
        format.html { redirect_to invitees_url, notice: 'Invitee was successfully created.' }
        format.json { render json: @invitee, status: :created, location: @invitee }
				format.js
      else
        @age = Age.all
        @gender = Gender.all
        @status = Status.all
        @couple = Couple.all
				@hosts = InviteeHost.all
        @inviteegroup = InviteeGroup.where(:user_account_id => current_user.user_account.id)
        
        format.html { render action: "new" }
        format.json { render json: @invitee.errors, status: :unprocessable_entity }
				format.js
      end
    end
  end

  # PUT /invitees/1
  # PUT /invitees/1.json
  def update
    @invitee = Invitee.find(params[:id])

    respond_to do |format|
      if @invitee.update_attributes(params[:invitee])
        format.html { redirect_to invitees_url, notice: 'Invitee was successfully updated.' }
        format.json { head :ok }
				format.js
      else
        @age = Age.all
        @gender = Gender.all
        @status = Status.all
        @couple = Couple.all
				@hosts = InviteeHost.all
        @inviteegroup = InviteeGroup.where(:user_account_id => current_user.user_account.id)
        
        
        format.html { render action: "edit"}
        format.json { render json: @invitee.errors, status: :unprocessable_entity }
				format.js
      end
    end
  end

  # DELETE /invitees/1
  # DELETE /invitees/1.json
  def destroy
    @invitee = Invitee.find(params[:id])
		@address = @invitee.address
		@address.destroy
    @invitee.destroy

    respond_to do |format|
      format.html { redirect_to invitees_url }
      format.json { head :ok }
			format.js
    end
  end 	

	def has_invitee		
		unless Invitee.exists?(params[:id]) && current_user.user_account.id == Invitee.find(params[:id]).user_account_id
			redirect_to invitees_path		
		end
	end
	
	def menu
		@invitees = Invitee.where(:user_account_id=> current_user.user_account.id)

		@confirmed_invitees = @invitees.count(:conditions=>'confirmed = true')
		@unconfirmed_invitees = @invitees.count(:conditions=>'confirmed = false')
		@total_invitees = @invitees.count
		
		@invitees.each do |i|
			if i.couple.present?
				unless i.couple.name == 'Sin Pareja'
					@total_invitees += 1
					i.confirmed ? @confirmed_invitees += 1 : @unconfirmed_invitees += 1
				end	
			end
		end		
		
	end
	
	def statistics	
		@invitees = Invitee.where(:user_account_id => current_user.user_account.id)


		@male_invitees = @invitees.joins(:gender).where('genders.gender like "H"').count  
		@female_invitees = @invitees.joins(:gender).where('genders.gender like "M"').count

		@confirmed_invitees = @invitees.count(:conditions=>'confirmed = true')
		@unconfirmed_invitees = @invitees.count(:conditions=>'confirmed = false')

		@invited_by_bride = @invitees.joins(:invitee_host).where('invitee_hosts.name like "Novia"').count
		@invited_by_groom = @invitees.joins(:invitee_host).where('invitee_hosts.name like "Novio"').count
		@invited_by_bride_parents = @invitees.joins(:invitee_host).where('invitee_hosts.name like "Papas Novia"').count
		@invited_by_groom_parents = @invitees.joins(:invitee_host).where('invitee_hosts.name like "Papas Novio"').count		

		@invitee_age_1 = @invitees.joins(:age).where('ages.range like "%?%"',14).count
		@invitee_age_2 = @invitees.joins(:age).where('ages.range like "%?%"',15).count
		@invitee_age_3 = @invitees.joins(:age).where('ages.range like "%?%"',19).count
		@invitee_age_4 = @invitees.joins(:age).where('ages.range like "%?%"',26).count
		@invitee_age_5 = @invitees.joins(:age).where('ages.range like "%?%"',36).count
		@invitee_age_6 = @invitees.joins(:age).where('ages.range like "?%"',45).count

		@invitees.each do |i|

      if i.couple.present?
        unless i.couple.name == 'Sin Pareja'
          i.gender.gender == 'H' ? @female_invitees += 1 : @male_invitees += 1
          i.confirmed ? @confirmed_invitees += 1 : @unconfirmed_invitees += 1

          if i.invitee_host.name == 'Novia'
            @invited_by_bride += 1
          elsif i.invitee_host.name == 'Novio'
            @invited_by_groom += 1
          elsif i.invitee_host.name.include? ' Novia'
            @invited_by_bride_parents += 1
          elsif i.invitee_host.name.include? ' Novio'
            @invited_by_groom_parents += 1
          end

          if i.age.present?
            if i.age.range == '0 - 14'
              @invitee_age_1 += 1
            elsif i.age.range == '15 - 18'
              @invitee_age_2 += 1
            elsif i.age.range == '19 - 25'
              @invitee_age_3 += 1
            elsif i.age.range == '26 - 35'
              @invitee_age_4 += 1
            elsif i.age.range == '36 - 45'
              @invitee_age_5 += 1
            elsif i.age.range == '45 +'
              @invitee_age_6 += 1
            end
            end
          end
      end
    end

		
		 respond_to do |format|
      format.html #statistics.html.erb
      format.json { head :ok }
			format.js {redirect_to  statistics_invitees_url}
    end

	end

  private
  def sort_column
    Invitee.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def redirect_if_guest
  	if current_user.role_id == 3 
  		redirect_to :action => :index
  	end
  end

end
