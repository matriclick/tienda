class CreateWedBenchmarks < ActiveRecord::Migration
  def change
    create_table :wed_benchmarks do |t|
      t.integer :industry_category_id
      t.decimal :precentage

      t.timestamps
    end
  end
end
