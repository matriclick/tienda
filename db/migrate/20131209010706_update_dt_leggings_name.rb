class UpdateDtLeggingsName < ActiveRecord::Migration
  def up
    dt = DressType.find_by_name "ropa-de-mujer-pantalones-leggins"
    dt.update_attribute :name, "ropa-de-mujer-pantalones-leggings"
    dt.update_attribute :description, "Leggings mujer"
    dt.save
  end

  def down
  end
end
