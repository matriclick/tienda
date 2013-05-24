class AddCountryIdToPost < ActiveRecord::Migration
  def change
    chile = Country.find_by_name('Chile')
    if !chile.nil?
      add_column :posts, :country_id, :integer, :default => chile.id
    end
  end
end
