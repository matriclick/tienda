class GenerateSlugsForProductsAndServices < ActiveRecord::Migration
  def up
    Product.find_each(&:save)
    Service.find_each(&:save)
  end

  def down
  end
end
