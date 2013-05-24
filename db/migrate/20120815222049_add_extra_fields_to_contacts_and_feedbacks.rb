class AddExtraFieldsToContactsAndFeedbacks < ActiveRecord::Migration
  def change
    add_column :contacts, :web_page_contact_state_id, :integer
    add_column :contacts, :status_description, :text
    add_column :feedbacks, :web_page_contact_state_id, :integer
    add_column :feedbacks, :status_description, :text
  end
end
