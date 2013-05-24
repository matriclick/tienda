class RocksController < ApplicationController
	before_filter :redirect_unless_admin
	
  # GET /rocks
  # GET /rocks.json
  def index
    @rocks = Rock.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rocks }
    end
  end

  # GET /rocks/1
  # GET /rocks/1.json
  def show
    @rock = Rock.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rock }
    end
  end

  # GET /rocks/new
  # GET /rocks/new.json
  def new
    @rock = Rock.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rock }
    end
  end

  # GET /rocks/1/edit
  def edit
    @rock = Rock.find(params[:id])
  end

  # POST /rocks
  # POST /rocks.json
  def create
    @rock = Rock.new(params[:rock])

    respond_to do |format|
      if @rock.save
        format.html { redirect_to @rock }
        format.json { render json: @rock, status: :created, location: @rock }
      else
        format.html { render 'new' }
        format.json { render json: @rock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rocks/1
  # PUT /rocks/1.json
  def update
    @rock = Rock.find(params[:id])

    respond_to do |format|
      if @rock.update_attributes(params[:rock])
        format.html { redirect_to @rock, notice: 'Rock was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @rock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rocks/1
  # DELETE /rocks/1.json
  def destroy
    @rock = Rock.find(params[:id])
    @rock.destroy

    respond_to do |format|
      format.html { redirect_to rocks_url }
      format.json { head :ok }
    end
  end
end
