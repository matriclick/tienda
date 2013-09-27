class DeleteAllScisWithoutSc < ActiveRecord::Migration
  def up
    ShoppingCartItem.all.each do |sci|
      if sci.shopping_cart.blank?
        puts sci.id
        sci.destroy
      end
    end
  end

  def down
  end
end
