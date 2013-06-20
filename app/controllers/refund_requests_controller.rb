# encoding: UTF-8
class RefundRequestsController < ApplicationController
  before_filter :redirect_unless_admin, :except => [:new, :create]
  before_filter :authenticate_user!
    
  # GET /refund_requests
  # GET /refund_requests.json
  def index
    @refund_requests = RefundRequest.order 'created_at DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @refund_requests }
    end
  end

  # GET /refund_requests/1
  # GET /refund_requests/1.json
  def show
    @refund_request = RefundRequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @refund_request }
    end
  end

  # GET /refund_requests/new
  # GET /refund_requests/new.json
  def new
    add_breadcrumb "Tramanta", :bazar_path
    add_breadcrumb "Solicitud de devolución", :new_refund_request_path
    
    @refund_request = RefundRequest.new
    @user_id = current_user.id
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @refund_request }
    end
  end

  # GET /refund_requests/1/edit
  def edit
    @refund_request = RefundRequest.find(params[:id])
    @user_id = @refund_request.user.id
  end

  # POST /refund_requests
  # POST /refund_requests.json
  def create
    @refund_request = RefundRequest.new(params[:refund_request])

    respond_to do |format|
      if @refund_request.save
        NoticeMailer.refund_request_email(@refund_request).deliver
        format.html { redirect_to root_country_path, notice: 'Solicitud de devolución correctamente ingresada.' }
        format.json { render json: @refund_request, status: :created, location: @refund_request }
      else
        format.html { render action: "new" }
        format.json { render json: @refund_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /refund_requests/1
  # PUT /refund_requests/1.json
  def update
    @refund_request = RefundRequest.find(params[:id])

    respond_to do |format|
      if @refund_request.update_attributes(params[:refund_request])
        format.html { redirect_to @refund_request, notice: 'Refund request was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @refund_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /refund_requests/1
  # DELETE /refund_requests/1.json
  def destroy
    @refund_request = RefundRequest.find(params[:id])
    @refund_request.destroy

    respond_to do |format|
      format.html { redirect_to refund_requests_url }
      format.json { head :ok }
    end
  end
end
