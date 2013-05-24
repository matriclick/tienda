class CreateCouples < ActiveRecord::Migration
  def change
    create_table :couples do |t|
      t.string :type

      t.timestamps
    end
  end
end
