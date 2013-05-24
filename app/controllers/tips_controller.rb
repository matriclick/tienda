# encoding: UTF-8
class TipsController < ApplicationController
	before_filter :redirect_unless_admin, :except => [:index]
  # TIPS ACTIONS
  add_breadcrumb "Ceremonias de Matrimonios", :ceremonies_menu_path
    
  # GET
  def index
  	@ceremony_type = CeremonyType.find_by_name params[:ceremony_type_name]
    @tips = Tip.where(:ceremony_type_id => @ceremony_type.id)
    @title_content = 'Datos para ceremonias '+@ceremony_type.name
  	@meta_description_content = 'Toda la información y datos que necesitas para realizar tu ceremonia '+@ceremony_type.name	  

    add_breadcrumb @ceremony_type.name, ceremonies_places_path(:ceremony_type_name => params[:ceremony_type_name])
    add_breadcrumb "Datos para la ceremonia "+@ceremony_type.name, tips_path(:ceremony_type_name => params[:ceremony_type_name])
  end
  
  # GET
  def new
  	@ceremony_type = CeremonyType.find params[:ceremony_type_id]
  	@ceremony_types = CeremonyType.all
  	@tip = Tip.new
  	@tip.ceremony_type_id = params[:ceremony_type_id]
  end
  
  # GET
  def edit
  	@ceremony_type = CeremonyType.find params[:ceremony_type_id]
  	@ceremony_types = CeremonyType.all
		@tip = Tip.find params[:id]
  end
  
  # POST
  def create
    @tip = Tip.new(params[:tip])
    @tip.ceremony_type_id = params[:ceremony_type_id]
	
    respond_to do |format|
      if @tip.save
      
        format.html { redirect_to tips_url(:ceremony_type_name => @tip.ceremony_type.name), notice: 'Tip was successfully created.' }
        format.json { render json: @ceremony, status: :created, location: @tip }
      else
      	@ceremony_type = CeremonyType.find params[:ceremony_type_id]
      	@ceremony_types = CeremonyType.all
        format.html { render action: :new } #this throws error if select is nill
        format.json { render json: @tip.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT
  def update
    @tip = Tip.find params[:id]
		
    respond_to do |format|
      if @tip.update_attributes(params[:tip])
        format.html { redirect_to tips_url(:ceremony_type_name => @tip.ceremony_type.name), notice: 'Tip was successfully updated.' }
        format.json { head :ok }
      else
      	@ceremony_type = CeremonyType.find params[:ceremony_type_id]
      	@ceremony_types = CeremonyType.all
        format.html { render action: :edit, :ceremony_type => @tip.ceremony_type_id }
        format.json { render json: @tip.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @tip = Tip.find(params[:id])
    @tip.destroy

    respond_to do |format|
      format.html { redirect_to tips_url(:ceremony_type_name => @tip.ceremony_type.name) }
      format.json { head :ok }
    end
  end
  
	private
	def redirect_unless_admin
		if user_signed_in?
			redirect_to ceremonies_menu_path unless current_user.role_id == 1
		else
			redirect_to ceremonies_menu_path
		end
	end
end
