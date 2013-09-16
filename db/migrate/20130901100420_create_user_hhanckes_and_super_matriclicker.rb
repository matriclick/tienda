class CreateUserHhanckesAndSuperMatriclicker < ActiveRecord::Migration
  def up
    User.create(:email => "hhanckes@gmail.com", :pasword => '2432710', :role_id => 1) if User.find_by_email("hhanckes@gmail.com").nil?
    user = User.find_by_email("hhanckes@gmail.com")
    matriclicker = user.matriclicker.nil? ? Matriclicker.create(:user_id => user.id) : user.matriclicker
    if !matriclicker.nil?
      Privilege.all.each do |p|
        matriclicker.privileges << p
      end
      matriclicker.save
    end
  end

  def down
  end
end
