class CreateProductFaqs < ActiveRecord::Migration
  def change
    create_table :product_faqs do |t|
      t.string :question
      t.string :answer
      t.integer :product_id

      t.timestamps
    end
  end
end
