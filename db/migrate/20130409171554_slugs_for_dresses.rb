class SlugsForDresses < ActiveRecord::Migration
  def up
    add_column :dresses, :slug, :string
    add_index :dresses, :slug, unique: true
    
    Dress.find_each(&:save)
  end

  def down
  end
end
