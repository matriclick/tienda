class AddUrlComingFromToSubscriber < ActiveRecord::Migration
  def change
    add_column :subscribers, :url_coming_from, :string
  end
end
