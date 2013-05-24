class ApproveAllReviews < ActiveRecord::Migration
  def up
    reviews = Review.all
    
    reviews.each do |r|
      r.update_attribute :approved_by_admin, true
    end
    
  end

  def down
    reviews = Review.all
    
    reviews.each do |r|
      r.update_attribute :approved_by_admin, nil
    end
  end
end
