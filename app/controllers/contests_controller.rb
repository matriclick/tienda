# encoding: UTF-8
class ContestsController < ApplicationController
  before_filter :authenticate_user!, :only => [:matridream, :subir_imagen, :vote]
  before_filter :redirect_to_facebook_login_unless_user_signed_in, :only => [:travelite_step1, :travelite_step2, :select_playeros, :select_viajeros]
  
  # BEGIN MATRIDREAM: Actions
  def matridream
    @title_content = 'Sueña tu Matrimonio'
    @user = current_user
    @matri_dream_ics = MatriDreamIc.all
    @industry_categories = []
    @matri_dream_ics.each do |matri_dream_ic|
      @industry_categories << matri_dream_ic.industry_category
    end
    @selections = @user.user_contest_selections
    @selections_confirmed = @selections.where(:confirmed => true).count
    
    @users_in_contest = []
    @all_confirmed_selections = UserContestSelection.where(:confirmed => true)
    @all_confirmed_selections.each do |confirmed_selection|
      if !@users_in_contest.include?(confirmed_selection.user)
        @users_in_contest << confirmed_selection.user
      end
    end
    @contest_vote_counts = ContestVoteCount.find(:all, :order=> 'matri_dream_ic_id, vote_count desc')
    @number_of_contest_vote_counts = 0
    @contest_vote_counts.each do |contest_vote_count|
      @number_of_contest_vote_counts = @number_of_contest_vote_counts + contest_vote_count.vote_count
    end
  end

  def matridream_rules
    @categories_in_contest = MatriDreamIc.all.count   
  end
  # END MATRIDREAM: Actions

  # BEGIN MATRIDREAM: Methods
  def add_supplier
    selections = UserContestSelection.where(:user_id => current_user.id, :matri_dream_ic_id => params[:matri_dream_ic_id])
    if selections.empty?
      UserContestSelection.create(:user_id => current_user.id, :matri_dream_ic_id => params[:matri_dream_ic_id], :supplier_account_id => params[:supplier_account], :confirmed => false)
    else
      selection = selections.first
      selection.update_attributes(:supplier_account_id => params[:supplier_account])
    end
    redirect_to contests_matridream_path
  end

  def confirm_selections
    selections = UserContestSelection.where(:user_id => current_user.id)
    selections.each do |selection|
      if !selection.confirmed
        selection.update_attributes(:confirmed => true)
        votes = ContestVoteCount.where(:matri_dream_ic_id => selection.matri_dream_ic_id, :supplier_account_id => selection.supplier_account_id)
        if votes.empty?
          ContestVoteCount.create(:matri_dream_ic_id => selection.matri_dream_ic_id, :supplier_account_id => selection.supplier_account_id, :vote_count => 1)
        else
          vote = votes.first
          vote.vote_count = vote.vote_count + 1
          vote.save
        end
      end
    end
    redirect_to contests_matridream_path
  end
  # END MATRIDREAM: Methods
  
  # BEGIN TRAVELITE: Actions
  def travelite
    if user_signed_in?
      @user = current_user
      if !!@user.contest_travelite
        @user_contest_travelite = @user.contest_travelite
        if @user_contest_travelite.selection == 'playero'
          @show_like_playero = true
        else
          @show_like_playero = false
        end
      end
    end
  end

  def travelite_step1
    user = current_user
    if !!user.contest_travelite
      redirect_to contests_travelite_path
    end
  end
  
  def travelite_step2
    user = current_user
    if !!user.contest_travelite
      if user.contest_travelite.selection == 'playero'
        @show_like_playero = true
      else
        @show_like_playero = false
      end
    else
      redirect_to contests_travelite_step1_path
    end
  end
  
  def travelite_rules
  end
  
  @@scrolling_set = 8
  def endless_scrolling    
    splited_ids = params[:ids].split(',')
    pending_contestant_ids = splited_ids[@@scrolling_set..splited_ids.length-1]
    @contestant_ids = pending_contestant_ids.to_s.gsub("\"","").gsub("[",'').gsub("]",'').gsub(" ",'')
    pending_contestant_count = pending_contestant_ids.blank? ? 0 :  pending_contestant_ids.count
    @last_set =  pending_contestant_count<=@@scrolling_set
    @contest_travelite_vote = params[:vote_id].to_i!=0 ? ContestTraveliteVote.find(params[:vote_id]) : false;
    @contest_travelites = Array.new

    for c in 0..[@@scrolling_set-1,pending_contestant_count-1].min
    @contest_travelites.push(ContestTravelite.find(pending_contestant_ids[c]))
    #Indica el concurso vigente:
    @box_partial_name = "contestants"
    end
    
  end

  def travelite_stage_1_ending
    @search_term = params[:q]
  
    if @search_term.nil? or @search_term.empty?
      @contest_travelites = ContestTravelite.where("contest_travelite_image_file_name is not null and contest_travelite_image_file_name <> ''")
    else
      @contest_travelites = ContestTravelite.
      where("contest_travelite_image_file_name is not null and contest_travelite_image_file_name <> '' and (
      groom_name like '%" + @search_term + "%' or
      bride_name like '%" + @search_term + "%' or
      photo_name like '%" + @search_term + "%')")
    end
    
    #IE v8 y anteriores no compatible con carga dinamica
    user_agent = request.env['HTTP_USER_AGENT']
    unless user_agent =~ /MSIE 8/ || user_agent =~ /MSIE 7/ || user_agent =~ /MSIE 6/ || user_agent =~ /MSIE 5/  
      @contestant_ids ="";
      @scrolling_set = @@scrolling_set
      @contest_travelites.each do |contestant|
        @contestant_ids += contestant.id.to_s + ','
      end
      @contest_travelites = @contest_travelites[0..@@scrolling_set-1]
    else
      @scrolling_set = @contest_travelites.length + 1
    end

    @contest_travelite_vote = ContestTraveliteVote.find_by_ip(request.remote_ip)
    if user_signed_in?
      @user = current_user
      if !!@user.contest_travelite
        @user_contest_travelite = @user.contest_travelite
        if @user_contest_travelite.selection == 'playero'
          @show_like_playero = true
          @most_voted = ContestTravelite.maximum(:vote_count)
        else
          @show_like_playero = false
        end
      end
    end
  end

  def travelite_stage_2_ending
    @search_term = params[:q]
  
    if @search_term.nil? or @search_term.empty?
      @contest_travelites = ContestTravelite.where("contest_travelite_image_file_name is not null and contest_travelite_image_file_name <> ''")
    else
      @contest_travelites = ContestTravelite.
      where("contest_travelite_image_file_name is not null and contest_travelite_image_file_name <> '' and (
      groom_name like '%" + @search_term + "%' or
      bride_name like '%" + @search_term + "%' or
      photo_name like '%" + @search_term + "%')")
    end
        
    @contest_travelites.sort! { |b,a| a.vote_count <=> b.vote_count }
    @contest_travelites = @contest_travelites[0..9]
    @contest_travelites= @contest_travelites.shuffle            
          
  end      

  def travelite_final
    @search_term = params[:q]
  
    if @search_term.nil? or @search_term.empty?
      @contest_travelites = ContestTravelite.where("contest_travelite_image_file_name is not null and contest_travelite_image_file_name <> ''")
    else
      @contest_travelites = ContestTravelite.
      where("contest_travelite_image_file_name is not null and contest_travelite_image_file_name <> '' and (
      groom_name like '%" + @search_term + "%' or
      bride_name like '%" + @search_term + "%' or
      photo_name like '%" + @search_term + "%')")
    end
        
    @contest_travelites.sort! { |b,a| a.vote_count <=> b.vote_count }
    @contest_travelites = @contest_travelites[0..9]
    @contest_travelites= @contest_travelites.shuffle

    @travelite_blog_posts_ids = { 124 => "patricio-y-karen",
                              28  => "alvaro-y-maria-jose",
                              835 => "patrick-y-cami--2",
                              89  => "juan-guillermo-y-carolina",
                              220 => "ignacio-y-maria-eliana",
                              47  => "pato-y-cata",
                              250 => "andres-y-ornella",
                              65  => "jan-y-rocio",
                              300 => "juan-pablo-y-daniela",
                              85  => "victor-y-barbara",
                              2  =>"bajoneros-s-a",  #de test
                              12 => "sonrisas-sin-censura"}  #de test   

    @travelite_final_name_fix = {"ignacio cifuentes" => "Ignacio",
                                  "maria eliana perez" => "María Eliana",
                                  "Pato Larrachea" => "Pato",
                                  "Cata Vallejos" => "Cata",
                                  "Juan Pablo Podlech" => "Juan Pablo",
                                  "Daniela Díaz" => "Daniela",
                                   "Juan Guillermo Norero" => "Juan Guillermo",
                                   "Carolina García Casanova" => "Carolina",
                                   "7tego" => "7test1",
                                   "Gustava" => "Gusi María Eliana"
                                }        
          
  end      
      
  def travelite_image
    if user_signed_in?
      @user = current_user
      @contest_travelite_vote = ContestTraveliteVote.find_by_user_id(@user.id)
    end
    @contest_travelite = ContestTravelite.find_by_slug(params[:slug])
    
    if @contest_travelite.nil?
      redirect_to despedida_de_soltera_path
    else
      @title_content = @contest_travelite.photo_name
  	  @meta_description_content = @contest_travelite.photo_name+' concursando para ganar una despedida de soltera en Buenos Aires. ¡Todo Incluído!'
      @og_type = 'article'
      @og_image = 'http://www.matriclick.com'+@contest_travelite.contest_travelite_image(:contest_travelite_big)
      @og_description = 'Vota por '+@contest_travelite.bride_name.to_s+' con su imagen '+@contest_travelite.photo_name.to_s+' que está concursando para ganar una despedida de soltera en Buenos Aires.'
    end    
  end
  
  def update_image
    user = current_user
    if user.contest_travelites
      @contest_travelite = ContestTravelite.find(params[:id])
      if @contest_travelite.update_attributes(params[:contest_travelite])
        redirect_to contests_image_path(:slug => @contest_travelite.slug), :notice => '¡Comparte la foto para que sume más votos!'
      else
        redirect_to contests_subir_imagen_path, :notice => 'Imagen no puede tener más de 1 MB'
      end
    else
      redirect_to despedida_de_soltera_path
    end
  end
  
  def create_travelite_vote
    contest_travelite_vote = ContestTraveliteVote.new
    contest_travelite_vote.contest_travelite_id = params[:contest_travelite_id]
    contest_travelite_vote.ip = params[:ip]
    if contest_travelite_vote.save
      contest_travelite = ContestTravelite.find(params[:contest_travelite_id])
      contest_travelite.vote_count = contest_travelite.vote_count + 1
      contest_travelite.save
    end
    redirect_to contests_travelite_path
  end
  # END TRAVELITE: Actions
  
  # BEGIN TRAVELITE: Methods
  def select_playeros
    user = current_user
    if !!user.contest_travelite
      redirect_to contests_travelite_path
    else
      ContestTravelite.create(:user_id => current_user.id, :selection => 'playero')
      redirect_to contests_travelite_step2_path
    end
  end
  
  def select_viajeros
    user = current_user
    if !!user.contest_travelite
      redirect_to contests_travelite_path
    else
      ContestTravelite.create(:user_id => current_user.id, :selection => 'viajero')
      redirect_to contests_travelite_step2_path
    end
  end
  # END TRAVELITE: Methods
  
  def despedida_de_soltera
    @title_content = 'Despedida de Soltera a Buenos Aires'
  	@meta_description_content = 'Concursa para ganar una despedida de soltera en Buenos Aires. ¡Todo Incluído!'
    @search_term = params[:q]
  
    if @search_term.nil? or @search_term.empty?
      @contest_travelites = ContestTravelite.where("contest_travelite_image_file_name is not null and contest_travelite_image_file_name <> '' and selection = 'despedida_de_soltera'").order 'vote_count DESC'
    else
      @contest_travelites = ContestTravelite.
      where("contest_travelite_image_file_name is not null and contest_travelite_image_file_name <> '' and (
      groom_name like '%" + @search_term + "%' or
      bride_name like '%" + @search_term + "%' or
      photo_name like '%" + @search_term + "%') and selection = 'despedida_de_soltera'").order 'vote_count DESC'
    end
    
    #IE v8 y anteriores no compatible con carga dinamica
    user_agent = request.env['HTTP_USER_AGENT']
    unless user_agent =~ /MSIE 8/ || user_agent =~ /MSIE 7/ || user_agent =~ /MSIE 6/ || user_agent =~ /MSIE 5/  
      @contestant_ids ="";
      @scrolling_set = @@scrolling_set
      @contest_travelites.each do |contestant|
        @contestant_ids += contestant.id.to_s + ','
      end
      @contest_travelites = @contest_travelites[0..@@scrolling_set-1]
    else
      @scrolling_set = @contest_travelites.length + 1
    end

    if user_signed_in?
      @user = current_user
      @contest_travelite_vote = ContestTraveliteVote.find_by_user_id(@user.id)
    end
  end
  
  def despedida_de_soltera_final
    @title_content = 'Despedida de Soltera a Buenos Aires'
  	@meta_description_content = 'Concursa para ganar una despedida de soltera en Buenos Aires. ¡Todo Incluído!'
    @contest_travelites = ContestTravelite.where("id = 1278 or id = 1288 or id = 1154 or id = 1323 or id = 1206").order('vote_count DESC')
    @og_type = 'article'
    @og_image = 'http://www.matriclick.com/assets/contests/despedida-de-soltera/despedida-de-soltera-final-f6ed531335faef43e7d6e36f86defb56.jpg'
    @og_description = 'Les presentamos a nuestras 5 finalistas, ellas deberán mostrar este jueves por qué se merecen ganar la ¡Despedida de Soltera Soñada!'    
  end
  
  def subir_imagen
    if user_signed_in?
      @user = current_user
      if @user.contest_despedida_de_soltera
        @user_contest_travelite = @user.contest_despedida_de_soltera
      else
        @user_contest_travelite = ContestTravelite.create(:user_id => @user.id, :selection => 'despedida_de_soltera', :bride_name => 'Nombre Novia', :photo_name => 'Nombre Foto', :position => 99)
      end
    end
  end
  
  def vote
		@contest_travelite = ContestTravelite.find_by_slug params[:slug]
		@user = current_user
		@vote = ContestTraveliteVote.find_by_user_id(@user.id)
		
		if @vote.nil?
      @vote = ContestTraveliteVote.create(:user_id => @user.id, :contest_travelite_id => @contest_travelite.id, :selection => 'despedida_de_soltera')
		  @contest_travelite.update_attribute(:vote_count, @contest_travelite.contest_travelite_votes.size)
    end
		
		respond_to do |format|
      format.html { redirect_to contests_image_path(:slug => @contest_travelite.slug), :notice => '¡Comparte la foto para que sume más votos!' }
      format.json { head :ok }
    end
  end
  
  def preambulo
    
  end

  def bases
  end
  
end
