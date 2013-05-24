class SupplierContactsController < ApplicationController
  before_filter :check_supplier, :set_supplier_layout, :find_supplier
  # GET /supplier_contacts
  # GET /supplier_contacts.json
  def index
    @supplier_contacts = @supplier.supplier_account.supplier_contacts

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @supplier_contacts }
    end
  end

  # GET /supplier_contacts/new
  # GET /supplier_contacts/new.json
  def new
		@supplier_account = @supplier.supplier_account
    @supplier_contact = SupplierContact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @supplier_contact }
    end
  end

  # GET /supplier_contacts/1/edit
  def edit
		@supplier_account = @supplier.supplier_account
    @supplier_contact = SupplierContact.find(params[:id])
  end

  # POST /supplier_contacts
  def create
    #AMK: Esto es un parche, ya que cuando no se está logueado como proveedor (logueado como user admin), en algún momento posterior a :find_supplier (no he encontrado donde), se busca el supplier según el id del supplier_account, por lo que en este punto, @supplier.id tiene lo que debería ser @supplier.supplier_account.id
	  if (user_signed_in? and !current_user.nil? and (current_user.role_id == 1))
      @supplier = SupplierAccount.find_by_public_url(params[:supplier_id]).supplier
		else
		  @supplier = current_supplier
		end
    
    @supplier_contact = SupplierContact.new(params[:supplier_contact])
    @supplier_account = @supplier.supplier_account
    @supplier_contact.supplier_account_id = @supplier_account.id

    respond_to do |format|
      if @supplier_contact.save
        format.html { redirect_to supplier_account_supplier_contacts_path(@supplier), :notice => "#{t('activerecord.successful.messages.created', :model =>  @supplier_contact.class.model_name.human)}" }
      else
        @supplier_account = @supplier.supplier_account
        format.html { render action: "new" }
      end
    end
  end

  # PUT /supplier_contacts/1
  def update
    #AMK: Esto es un parche, ya que cuando no se está logueado como proveedor (logueado como user admin), en algún momento posterior a :find_supplier (no he encontrado donde), se busca el supplier según el id del supplier_account, por lo que en este punto, @supplier.id tiene lo que debería ser @supplier.supplier_account.id
	  if (user_signed_in? and !current_user.nil? and (current_user.role_id == 1))
      @supplier = Supplier.find(SupplierAccount.find(@supplier.id).supplier_id)
		else
		  @supplier = current_supplier
		end

    @supplier_contact = SupplierContact.find(params[:id])
    respond_to do |format|
      if @supplier_contact.update_attributes(params[:supplier_contact])
        format.html { redirect_to supplier_account_supplier_contacts_path(@supplier), :notice => "#{t('activerecord.successful.messages.updated', :model =>  @supplier_contact.class.model_name.human)}" }
      else
        @supplier_account = @supplier.supplier_account
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /supplier_contacts/1
  def destroy
    @supplier_contact = SupplierContact.find(params[:id])
    @supplier_contact.destroy

    respond_to do |format|
      format.html { redirect_to supplier_account_supplier_contacts_url(@supplier) }
    end
  end
end
