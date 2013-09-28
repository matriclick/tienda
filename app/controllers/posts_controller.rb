# encoding: UTF-8
class PostsController < ApplicationController
  before_filter :redirect_unless_admin, :except => [:blog, :show]
  include ActionView::Helpers::SanitizeHelper
  
  def blog
    @posts = Post.where(:country_id => session[:country].id, :post_type => 'Post').is_visible.order('created_at DESC').limit 35
	  @slider_images = SliderImage.where(:country_id => session[:country].id, :slider_image_type_id => 2).order(:position)
  	
  	@title_content = 'Reportajes de Matrimonios'
  	@meta_description_content = 'Toda la información que necesitas: datos, anécdotas e historias para que te prepares para tu Matrimonio'
    add_breadcrumb "Revista Matriclick", :blog_path
  end
  
  def index
    @posts = Post.order 'created_at DESC'
    add_breadcrumb "Listado de posts", :posts_path
    
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
    @related_posts = Post.is_visible.order('created_at DESC').limit 6
    @related_posts = @related_posts - [@post]
    
    @title_content = @post.title
  	@meta_description_content = @post.introduction
    @og_type = 'article'
    @og_image = 'http://www.tramanta.com'+@post.main_image.url(:original)
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
    add_breadcrumb "Listado de posts", :posts_path
    add_breadcrumb "Nuevo post", :new_post_path
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
    add_breadcrumb "Listado de posts", :posts_path
    add_breadcrumb "Editar post", edit_post_path(@post)
    
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
    add_breadcrumb "Blog Tramanta", :blog_el_bazar_path
    add_breadcrumb @post.title, @post   
  end
end
