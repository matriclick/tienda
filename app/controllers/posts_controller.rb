# encoding: UTF-8
class PostsController < ApplicationController
  before_filter :redirect_unless_admin, :hide_left_menu, :except => [:blog, :show]
  include ActionView::Helpers::SanitizeHelper
  
  def blog
    @posts = Post.where(:country_id => session[:country].id, :post_type => 'Post').is_visible.order('created_at DESC').limit 35
	  @slider_images = SliderImage.where(:country_id => session[:country].id, :slider_image_type_id => 2).order(:position)
  	
  	@title_content = 'Reportajes de Matrimonios'
  	@meta_description_content = 'Toda la información que necesitas: datos, anécdotas e historias para que te prepares para tu Matrimonio'
    add_breadcrumb "Revista Matriclick", :blog_path
  end
  
  def index
    @posts = Post.where(:country_id => session[:country].id).order 'created_at DESC'
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @related_dresses = Dress.get_related_dresses_by_string(@post.product_keywords)
    
    case @post.post_type
      when 'Post'
        @related_posts = Post.where(:country_id => session[:country].id).by_industry_category(@post.industry_category_id).not_id(@post.id)
        sa_type = SupplierAccountType.find_by_name("Regular");
        @related_supplier_accounts = SupplierAccount.where(:country_id => session[:country].id, :supplier_account_type_id => sa_type.id).by_industry_category(@post.industry_category_id).approved.sort_by {|sa| sa.reviews.approved.size}.reverse
      else
        @related_posts = Post.where(:country_id => session[:country].id, :post_type => @post.post_type).is_visible.order('created_at DESC')
        @related_posts = @related_posts - [@post]
    end
    
    @title_content = @post.title
  	@meta_description_content = @post.introduction
    @og_type = 'article'
    @og_image = 'http://www.matriclick.com'+@post.main_image.url(:original)
    @og_description = strip_tags(@post.introduction).gsub('&','').gsub(/acute;/,'')
		get_breadcrumb(@post)
		
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
	  3.times do
		 post_content = @post.post_contents.build
		 1.times { post_content.post_images.build }
	end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
		
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end
  
  def check_older_guests # DZF check for guests older than 1 week and destroy them
		begin
			UserAccount.joins(:users).where('users.role_id = 3 and created_at <= ? ', Time.now - 3.weeks).destroy_all
		rescue
			logger.info  "---------> ERROR WHEN clearing older guest users" 
		end
  end

	private
	def redirect_unless_admin
		if !user_signed_in? or current_user.role_id != 1
  			redirect_to blog_url
		end
	end
  
  def get_breadcrumb(post)
    case @post.post_type    
      when 'Post'
        add_breadcrumb "Revista Matriclick", :blog_path
      when 'Pack'
        add_breadcrumb "Casonas y Centros de Eventos", :casonas_matriclick_path
      when 'Lunas de Miel'
        add_breadcrumb "Blog Lunas de miel", :lunas_de_miel_path
      when 'El Bazar'
        add_breadcrumb "Blog El Bazar", :blog_el_bazar_path
      when 'Tu Casa'
        add_breadcrumb "Blog Tu Casa", :blog_tu_casa_path
      when 'Viajes'
        add_breadcrumb "Blog Viajes", :blog_viajes_path
      when 'Aguclick'
        add_breadcrumb "Blog Aguclick", :blog_aguclick_path
      else
        add_breadcrumb "Revista Matriclick", :blog_path
    end
    add_breadcrumb @post.title, @post   
  end
end
