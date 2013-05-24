# coding: utf-8
class CampaignController < ApplicationController
	before_filter :sign_out_guest, :except => [:give_it_away, :rate, :vote_up]
	
  def anecdotes
		@anecdote = CampaignAnecdote.find params[:id] || CampaignAnecdote.first
		@count = CampaignAnecdote.all.size
		if @anecdote == CampaignAnecdote.last
			@i = @count
		else
			@i = CampaignAnecdote.all.index(@anecdote) + 1
		end
		
		respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dress }
    end
  end

	def rate
		@anecdote = CampaignAnecdote.find params[:id]
	end

  def supplier_gallery
		# FGM: Disabled for the moment
		redirect_to campaign_winners_url
		@item = CampaignGalleryItem.find params[:id] || CampaignGalleryItem.first
		@related_supplier_account = SupplierAccount.find_by_fantasy_name @item.tag
		@count = CampaignGalleryItem.all.size
		if @item == CampaignGalleryItem.last
			@i = @count
		else
			@i = CampaignGalleryItem.all.index(@item) + 1
		end
  end

  def bases
  end

  def wedding_of_the_year
  end

  def gallery
  end

  def d_day
  end

  def suppliers
    @supplier_account_number = 1
    @continue = true
    @supplier_accounts = []
    @supplier_accounts << SupplierAccount.find_by_public_url('studiosnaps')
		@supplier_accounts << SupplierAccount.find_by_public_url('tumatriesunico')
		@supplier_accounts << SupplierAccount.find_by_public_url('rosatocados')
		@supplier_accounts << SupplierAccount.find_by_public_url('canasto')
		@supplier_accounts << SupplierAccount.find_by_public_url('indigo')
		@supplier_accounts << SupplierAccount.find_by_public_url('mariasolita')
		@supplier_accounts << SupplierAccount.find_by_public_url('carolinaalcalde')
		@supplier_accounts << SupplierAccount.find_by_public_url('calabrese')
		@supplier_accounts << SupplierAccount.find_by_public_url('rinaldoverdi')
  end

	def suggested_wedding
	end

	def winners
    @winners = CampaignUserAccountInfo.find(400)
    @title_content = ' - Mejor Propuesta de Matrimonio'
    @meta_description_content = "La mejor propuesta de Matrimonio 2012 se llevó el premio de $8 millones."
	end

	def ending
    @title_content = ' - Concurso - Propuesta de Matrimonio'
    @meta_description_content = "Fotos y reportajes de la Gran Final del concurso: La mejor propuesta de Matrimonio 2012."
	end

	def finalists
    @winners = CampaignUserAccountInfo.find(400)
    @parachute = CampaignUserAccountInfo.find(242)
    @hamburger = CampaignUserAccountInfo.find(39)
    @new_york = CampaignUserAccountInfo.find(223)
    @trekking = CampaignUserAccountInfo.find(53)		
    @title_content = ' - Mejores Propuestas de Matrimonio'
    @meta_description_content = "Puedes revisar las mejores propuestas de Matrimonio 2012 que participaron en el concurso Matriclick por un premio de $8 millones."
	end

	def thanks
	  @supplier_accounts = SupplierAccount.where(:id => [34, 61, 104, 364, 691, 692])  
    @title_content = ' - Concurso - Agradecimientos'
    @meta_description_content = "Los proveedores de productos y servicios de matrimonio que nos acompañaron en el concurso Matriclick."
	end

  def noviosparis
  end

  def studiosnaps
  end
  
  def lasadrianas
  end
  
  def rimon
  end
  
  def marialuisagarcia
  end
  
  def micapricho
  end
  
  def alejandrasanchez
  end
  
  def how_to_win
    @ip_votes = ip_votes?
    @campaign_user_accounts = CampaignUserAccountInfo.all
    @title_content = ' - Propuestas de Matrimonio'
    @meta_description_content = "Puedes revisar todas las propuestas de Matrimonio 2012 que participaron en el concurso Matriclick por un premio de $8 millones."
  end

	def user_story
		@campaign_user_account = CampaignUserAccountInfo.find params[:id]
		
		respond_to do |format|
			format.html
		end
	end

  def give_it_away		
		@genders = Gender.all
		@rock = Rock.new
  end

	def create_rock
		@rock = Rock.new params[:rock]
		@rock.sender_email ||= current_user.email
		
		respond_to do |format|
			if @rock.save
				UserMailer.rock_email(@rock).deliver
				UserMailer.rock_email(@rock, true).deliver
				format.html { redirect_to campaign_give_it_away_url, :notice => "Listo! Ya se envió a #{@rock.recipient_email}!" }
			else
				@genders = Gender.all
				format.html { render 'give_it_away' }
			end
		end
	end

	def vote_up
		@campaign_user_account_info = CampaignUserAccountInfo.find params[:id]
    @votes = ip_votes?
    if ip_votes?
      if user_signed_in?
        @campaign_user_account_info.cua_votes << CuaVote.create!(user_id:current_user.id, :ip => request.remote_ip.to_s)
      else
        if cookies[:cua_voted].blank?
          cookies[:cua_voted] = "#{@campaign_user_account_info.id},"
          @campaign_user_account_info.cua_votes << CuaVote.create!(:ip => request.remote_ip.to_s)
        elsif !(cookies[:cua_voted].split(",").include? params[:id])
          cookies[:cua_voted] += "#{@campaign_user_account_info.id},"
          @campaign_user_account_info.cua_votes << CuaVote.create!(:ip => request.remote_ip.to_s)
        end
      end          
    end
    respond_to do |format|
        format.html { redirect_to campaign_how_to_win_url }
        format.js
      end
  end

	private
	def sign_out_guest
		# FGM: Sign out guest user so when he jumps to "give_it_away" is no longer signed_in
		sign_out(:user) if user_signed_in? && current_user.guest?				
  end

  def ip_votes?
    CuaVote.where(:ip=>request.remote_ip.to_s).count < 2
  end


end
