class AddStatusToContest < ActiveRecord::Migration
  def change
    add_column :contests, :status, :string
  end
end
