# encoding: UTF-8
class PackPromotionsController < ApplicationController
  before_filter :redirect_unless_admin, :hide_left_menu
  
  def index
    @pack_promotions = PackPromotion.all
    @packs = Post.where(:country_id => session[:country].id, :post_type => 'Pack').order('created_at DESC')
  end
  
  def new
    @pack_promotion = PackPromotion.new
    @packs = Post.where(:country_id => session[:country].id, :post_type => 'Pack').order('created_at DESC')
  end
  
  def create
    @pack_promotion = PackPromotion.new(params[:pack_promotion])
    
    if @pack_promotion.save
      redirect_to pack_promotions_path, notice: 'Pack Promotion was successfully created.'
    else
      @packs = Post.where(:country_id => session[:country].id, :post_type => 'Pack').order('created_at DESC')
      render action: "new"
    end
  end
  
  def edit
    @pack_promotion = PackPromotion.find(params[:id])
    @packs = Post.where(:country_id => session[:country].id, :post_type => 'Pack').order('created_at DESC')
  end
  
  def update
    @pack_promotion = PackPromotion.find(params[:id])

    if @pack_promotion.update_attributes(params[:pack_promotion])
      redirect_to pack_promotions_path, notice: 'Pack Promotion was successfully updated.'
    else
      @packs = Post.where(:country_id => session[:country].id, :post_type => 'Pack').order('created_at DESC')
      render action: "edit"
    end
  end
  
  def update_multiple
    if !params[:pack_promotions].blank?
      params[:pack_promotions].keys.each do |key|
        if params[:pack_promotions][key][:post_ids].nil?
          params[:pack_promotions][key][:post_ids] = []
        end
      end
      @pack_promotions = PackPromotion.update(params[:pack_promotions].keys, params[:pack_promotions].values).reject { |pack_promotion| pack_promotion.errors.empty? }
      
      if @pack_promotions.empty?
        redirect_to pack_promotions_path
      else
        @packs = Post.where(:country_id => session[:country].id, :post_type => 'Pack').order('created_at DESC')
        render :action => "index"
      end
    else
      redirect_to pack_promotions_path
    end
  end

  def destroy
    @pack_promotion = PackPromotion.find(params[:id])
    @pack_promotion.destroy

    redirect_to pack_promotions_url
  end
  
end
