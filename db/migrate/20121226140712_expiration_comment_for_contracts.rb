class ExpirationCommentForContracts < ActiveRecord::Migration
  def up
    add_column :contracts, :expiration_comment, :string
  end

  def down
    remove_column :contracts, :expiration_comment
  end
end
