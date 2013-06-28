class DeleteUsersTry2 < ActiveRecord::Migration
  def up
    u = User.where('role_id <> 1')
    size = u.size
    i = 1
    u.each do |user|
      puts user.email
      puts i.to_s+'/'+size.to_s
      user.destroy
      i = i + 1
    end
    
  end

  def down
  end
end
