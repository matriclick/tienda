class TextFieldsForContestTravelites < ActiveRecord::Migration
  def change
    add_column :contest_travelites, :groom_name, :string
    add_column :contest_travelites, :bride_name, :string
    add_column :contest_travelites, :photo_name, :string
  end
end
