class AlbumsController < ApplicationController
    before_filter :check_supplier, :set_supplier_layout, :find_supplier

  	def index
      @albums = @supplier.supplier_account.albums
    end

    def show
    end

    def new
      @album = Album.new
      @industry_categories = @supplier.supplier_account.industry_categories
    end

    def edit
      @album = Album.find(params[:id])
      @industry_categories = @supplier.supplier_account.industry_categories
    end

    def create
      @album = Album.new(params[:album])
      @album.supplier_account_id = @supplier.supplier_account.id
      @industry_categories = @supplier.supplier_account.industry_categories
      
      respond_to do |format|
        if @album.save
          format.html { redirect_to supplier_account_albums_url, :notice => "#{t('activerecord.successful.messages.created', :model => @album.class.model_name.human)}" }
        else
          format.html { render action: "new" }
        end
      end
    end

    def update
      @album = Album.find(params[:id])
      @industry_categories = @supplier.supplier_account.industry_categories
      
      respond_to do |format|
        if @album.update_attributes(params[:album])
          format.html { redirect_to supplier_account_albums_url, :notice => "#{t('activerecord.successful.messages.updated', :model =>  @album.class.model_name.human)}"  }
        else
          format.html { render action: "edit" }
        end
      end
    end

    def destroy
      @album = Album.find(params[:id])
      @album.destroy

      respond_to do |format|
        format.html { redirect_to supplier_account_albums_url(@supplier) }
      end
      
    end
end
