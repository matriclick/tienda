class SupplierWithoutAccountsController < ApplicationController
  before_filter :redirect_unless_admin, :hide_left_menu
  # GET /supplier_without_accounts
  # GET /supplier_without_accounts.json
  def index
    @supplier_without_accounts = SupplierWithoutAccount.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @supplier_without_accounts }
    end
  end

  # GET /supplier_without_accounts/1
  # GET /supplier_without_accounts/1.json
  def show
    @supplier_without_account = SupplierWithoutAccount.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @supplier_without_account }
    end
  end

  # GET /supplier_without_accounts/new
  # GET /supplier_without_accounts/new.json
  def new
    @supplier_without_account = SupplierWithoutAccount.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @supplier_without_account }
    end
  end

  # GET /supplier_without_accounts/1/edit
  def edit
    @supplier_without_account = SupplierWithoutAccount.find(params[:id])
  end

  # POST /supplier_without_accounts
  # POST /supplier_without_accounts.json
  def create
    @supplier_without_account = SupplierWithoutAccount.new(params[:supplier_without_account])

    respond_to do |format|
      if @supplier_without_account.save
        format.html { redirect_to @supplier_without_account, notice: 'Supplier without account was successfully created.' }
        format.json { render json: @supplier_without_account, status: :created, location: @supplier_without_account }
      else
        format.html { render action: "new" }
        format.json { render json: @supplier_without_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /supplier_without_accounts/1
  # PUT /supplier_without_accounts/1.json
  def update
    @supplier_without_account = SupplierWithoutAccount.find(params[:id])

    respond_to do |format|
      if @supplier_without_account.update_attributes(params[:supplier_without_account])
        format.html { redirect_to @supplier_without_account, notice: 'Supplier without account was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @supplier_without_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supplier_without_accounts/1
  # DELETE /supplier_without_accounts/1.json
  def destroy
    @supplier_without_account = SupplierWithoutAccount.find(params[:id])
    @supplier_without_account.destroy

    respond_to do |format|
      format.html { redirect_to supplier_without_accounts_url }
      format.json { head :ok }
    end
  end
end
