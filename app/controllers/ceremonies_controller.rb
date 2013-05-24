# encoding: UTF-8
class CeremoniesController < ApplicationController
	before_filter :redirect_unless_admin, :except => [:menu, :places]
  add_breadcrumb "Ceremonias de Matrimonios", :ceremonies_menu_path
  
  # GET /ceremonies
  # GET /ceremonies.json
  def index
    @ceremonies = Ceremony.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ceremonies }
    end  	
  end

  # GET /ceremonies/1
  # GET /ceremonies/1.json
  def show
    @ceremony = Ceremony.find(params[:id])
  
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ceremony }
    end
  end

  # GET /ceremonies/new
  # GET /ceremonies/new.json
  def new
  	@ceremony_types = CeremonyType.all
    @ceremony = Ceremony.new
    
    1.times { @ceremony.ceremony_images.build }
    1.times { @ceremony.build_address }
    1.times { @ceremony.ceremony_days.build }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ceremony }
    end
  end

  # GET /ceremonies/1/edit
  def edit
  	@ceremony_types = CeremonyType.all
    @ceremony = Ceremony.find(params[:id])
  end

  # POST /ceremonies
  # POST /ceremonies.json
  def create
    @ceremony = Ceremony.new(params[:ceremony])

    respond_to do |format|
      if @ceremony.save
      
        format.html { redirect_to ceremonies_menu_url(), notice: 'Ceremony was successfully created.' }
        format.json { render json: @ceremony, status: :created, location: @ceremony }
      else
      	@ceremony_types = CeremonyType.all
        format.html { render action: "new" }
        format.json { render json: @ceremony.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ceremonies/1
  # PUT /ceremonies/1.json
  def update
    @ceremony = Ceremony.find(params[:id])

    respond_to do |format|
      if @ceremony.update_attributes(params[:ceremony])
        format.html { redirect_to ceremonies_menu_url(), notice: 'Ceremony was successfully updated.' }
        format.json { head :ok }
      else
      	@ceremony_types = CeremonyType.all
        format.html { render action: "edit" }
        format.json { render json: @ceremony.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ceremonies/1
  # DELETE /ceremonies/1.json
  def destroy
    @ceremony = Ceremony.find(params[:id])
    @ceremony.destroy

    respond_to do |format|
      format.html { redirect_to ceremonies_url }
      format.json { head :ok }
    end
  end
  
  def menu
  	@ceremony_types = CeremonyType.all
  	@title_content = 'Ceremonias de Matrimonio'
  	@meta_description_content = 'Toda la información que necesitas para encontrar el lugar para realizar tu ceremonia de matrimonio y datos útiles y prácticos para preparar día'	  
  end
  
  def places
  	@ceremony_type = CeremonyType.find_by_name params[:ceremony_type_name]
    @ceremonies = Ceremony.where(:ceremony_type_id => @ceremony_type.id).order("created_at").paginate(:page => params[:page], :per_page => 20)
    unless @ceremony_type.name.blank?
    	@title_content = 'Ceremonia ' + @ceremony_type.name
      @meta_description_content = "Datos y lugares de ceremonias de matrimonio " + @ceremony_type.name
      add_breadcrumb @ceremony_type.name, ceremonies_places_path(:ceremony_type_name => params[:ceremony_type_name])
    end
  end
  
	private
	def redirect_unless_admin
		if user_signed_in?
			redirect_to ceremonies_menu_url unless current_user.role_id == 1
		else
			redirect_to ceremonies_menu_url
		end
	end
end
