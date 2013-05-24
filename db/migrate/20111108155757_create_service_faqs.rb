class CreateServiceFaqs < ActiveRecord::Migration
  def change
    create_table :service_faqs do |t|
      t.string :question
      t.string :answer
      t.integer :service_id

      t.timestamps
    end
  end
end
