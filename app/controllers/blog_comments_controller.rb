class BlogCommentsController < ApplicationController
	
	def create
		@blog_comment = BlogComment.new(params[:blog_comment])
		@blog_comment.post_id = params[:post_id]
		
		respond_to do |format|
			if @blog_comment.save
				format.html { redirect_to :back }
				format.json { render json: @blog_comment, status: :created, location: @blog_comment }
			else
				format.html { render action: "new" }
				format.json { render json: @blog_comment.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
	end
  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @blog_comment = BlogComment.find(params[:id])
    @blog_comment.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end
end
