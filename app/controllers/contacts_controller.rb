class ContactsController < ApplicationController

  def new
    @contact = Contact.new
    #SEO: @title_content =
    #SEO: @meta_description_content =
    respond_to do |format|
      format.html
      format.json { render json: @contact }
    end
  end
  
  def create
    params[:contact][:company] = 'el_bazar' if params[:sent_from] == 'el_bazar'
    
    @contact = Contact.create params[:contact]
    @notice = 'Contacto fue enviado exitosamente :-)'
    
    
    respond_to do |format|
      if @contact.save
        format.html { params[:sent_from] == 'el_bazar' ? redirect_to(bazar_path(), notice: @notice) : redirect_to(company_path(), notice: @notice) }
        format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { params[:sent_from] == 'el_bazar' ? render(contact_elbazar_path()) : render(action: "new") }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end
end
