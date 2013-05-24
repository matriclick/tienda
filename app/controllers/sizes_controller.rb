class SizesController < ApplicationController
  before_filter :redirect_unless_admin, :hide_left_menu
  before_filter { redirect_unless_privilege('Vestidos') }
  # GET /sizes
  # GET /sizes.json
  def index
    @sizes = Size.all
    @dress_types = DressType.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sizes }
    end
  end

  # GET /sizes/1
  # GET /sizes/1.json
  def show
    @size = Size.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @size }
    end
  end

  # GET /sizes/new
  # GET /sizes/new.json
  def new
    @size = Size.new
    @dress_types = DressType.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @size }
    end
  end

  # GET /sizes/1/edit
  def edit
    @size = Size.find(params[:id])
    @dress_types = DressType.all
  end

  # POST /sizes
  # POST /sizes.json
  def create
    @size = Size.new(params[:size])

    respond_to do |format|
      if @size.save
        format.html { redirect_to sizes_path, notice: 'Size was successfully created.' }
        format.json { render json: @size, status: :created, location: @size }
      else
        format.html { render action: "new" }
        format.json { render json: @size.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sizes/1
  # PUT /sizes/1.json
  def update
    @size = Size.find(params[:id])

    respond_to do |format|
      if @size.update_attributes(params[:size])
        format.html { redirect_to @size, notice: 'Size was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @size.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_multiple
    params[:sizes].keys.each do |key|
      if params[:sizes][key][:dress_type_ids].nil?
        params[:sizes][key][:dress_type_ids] = []
      end
    end
    @sizes = Size.update(params[:sizes].keys, params[:sizes].values).reject { |size| size.errors.empty? }
    if @sizes.empty?
      DressStockSize.all.each do |dress_stock_size|
        if !dress_stock_size.dress.dress_type.sizes.include?(dress_stock_size.size)
          dress_stock_size.destroy
        end
      end
      redirect_to sizes_path
    else
      render :action => "index"
    end
  end

  # DELETE /sizes/1
  # DELETE /sizes/1.json
  def destroy
    @size = Size.find(params[:id])
    @size.destroy

    respond_to do |format|
      format.html { redirect_to sizes_url }
      format.json { head :ok }
    end
  end
end
