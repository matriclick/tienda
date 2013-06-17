class CreateMailings < ActiveRecord::Migration
  def change
    create_table :mailings do |t|
      t.datetime :date_sent
      t.integer :users_sent
      t.datetime :dresses_start_date
      t.datetime :dresses_end_date

      t.timestamps
    end
  end
end
