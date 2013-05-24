class InvitationsController < ApplicationController
before_filter :authenticate_user!
before_filter :get_data, :only=>[:new,:create]
before_filter :has_invitation, :only=>[:edit,:update,:show]

	def index		
		@invitation = Invitation.where(:user_account_id => current_user.user_account.id).first
		retrieve_text
		

		respond_to do |format|
      format.html       
			format.js
    end
	end


	def show
		respond_to do |format|
      format.html {redirect_to invitations_url}
      format.json { render json: @invitation }
			format.js
    end
	end


	def new
		@invitation = Invitation.new		
		
		
		respond_to do |format|
      format.html 
      format.json { render json: @invitation }
			format.js
    end
	end
	

	def create
		@invitation = Invitation.new(params[:invitation])
		@invitation.user_account = current_user.user_account
		save_text
		
		#@invitation.background_image
			

		respond_to do |format|
      if @invitation.save
        format.html { redirect_to invitations_url, notice: 'Invitation was successfully created.' }
        format.json { render json: @invitation, status: :created, location: @invitation }
				format.js
      else       
        format.html { render action: "new" }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
				format.js
      end
    end
	end


	def edit
		@invitation = Invitation.find(params[:id])		
		retrieve_text

		
		
		respond_to do |format|
		    format.html 
		    format.json { render json: @invitation }
				format.js
		  end
	end


	def update
		@invitation = Invitation.find(params[:id])
		save_text
		respond_to do |format|
			if @invitation.save
				format.html { redirect_to invitations_url, notice: 'Invitation was successfully updated.' }
				format.json { render json: @invitation, status: :created, location: @invitation }
				format.js
			else       
				format.html { render action: "new" }
				format.json { render json: @invitation.errors, status: :unprocessable_entity }
				format.js
			end
		end
	end



  def destroy
  	@invitation = Invitation.find(params[:id])		
  	@invitation.destroy

	  respond_to do |format|
	    format.html { redirect_to invitations_url }
	    format.json { head :ok }
			format.js
	  end
	end 


	def get_data
		@user_account = current_user.user_account
			invitees = Invitee.where(:user_account_id => current_user.user_account.id)
		
			groom_father = invitees.find(:first,:joins=>:invitee_role,:conditions=>'invitee_roles.name like "Papa del Novio"')
			groom_mother = invitees.find(:first,:joins=>:invitee_role,:conditions=>'invitee_roles.name like "Mama del Novio"')
			bride_father = invitees.find(:first,:joins=>:invitee_role,:conditions=>'invitee_roles.name like "Papa de la Novia"')
		 	bride_mother = invitees.find(:first,:joins=>:invitee_role,:conditions=>'invitee_roles.name like "Mama de la Novia"')

			@groom_name = (@user_account.groom.name.blank? ? 'Nombre Novio' : @user_account.groom.name) 
			@bride_name = (@user_account.bride.name.blank? ? 'Nombre Novia' : @user_account.bride.name)
			@groom_father_name = (groom_father.blank? ? 'Nompre Papa Novio' : [groom_father.name, groom_father.lastname_p, groom_father.lastname_m].join(' ')) 
			@groom_mother_name = (groom_mother.blank? ? 'Nombre Mama Novio' : [groom_mother.name, groom_mother.lastname_p, groom_mother.lastname_m].join(' ')) 

			@bride_father_name = (bride_father.blank? ? 'Nombre Papa Novia' : [bride_father.name, bride_father.lastname_p, bride_father.lastname_m].join(' ')) 
			@bride_mother_name = (bride_mother.blank? ? 'Nombre Mama Novia' : [bride_mother.name, bride_mother.lastname_p, bride_mother.lastname_m].join(' '))

			@wedding_day = @user_account.wedding_tentative_date.day
			@wedding_month = @user_account.wedding_tentative_date.strftime('%B')

			@city =  (@user_account.wedding_city.blank? ? 'Ciudad' : @user_account.wedding_city)		
	end

	def save_text
		@upper_right = params[:live_upper_right].gsub(/\r\n/,'%#%LB')
		@upper_left = params[:live_upper_left].gsub(/\r\n/,'%#%LB')
		@mid_1 = params[:live_mid_1].gsub(/\r\n/,'%#%LB')
		@mid_2 = params[:live_mid_2].gsub(/\r\n/,'%#%LB')
		@lower = params[:live_lower].gsub(/\r\n/,'%#%LB')
		
		@invitation.text = "{\"upper_right\":\""+@upper_right+"\",\"upper_left\":\""+@upper_left+"\",\"mid_1\":\""+@mid_1+"\",\"mid_2\":\""+@mid_2+"\",\"lower\":\""+@lower+"\"	}"
	end
	
	def retrieve_text
		hash = JSON.parse(@invitation.text.gsub('\"','"'))
		@upper_left = hash['upper_left'].gsub('%#%LB','\r\n')
		@upper_right = hash['upper_right'].gsub('%#%LB','\r\n')
		@mid_1 = hash['mid_1'].gsub('%#%LB','\r\n')
		@mid_2 = hash['mid_2'].gsub('%#%LB','\r\n')
		@lower = hash['lower'].gsub('%#%LB','\r\n')
	end


	def has_invitation	
		unless Invitation.exists?(params[:id]) && current_user.user_account.id == Invitation.find(params[:id]).user_account_id
			redirect_to invitations_url	
		end
	end

end
