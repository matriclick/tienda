class FeedbacksController < ApplicationController
  def create
    @feedback = Feedback.create params[:feedback]
    if user_signed_in?
      @feedback.user_id = current_user.id
    elsif supplier_signed_in?
      @feedback.supplier_id = current_supplier.id
    end

    respond_to do |format|
      if @feedback.save
        format.html { redirect_to :back }
      else
        format.html { redirect_to :back }
      end      
    end    
  end
end
