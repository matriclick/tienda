class DeleteAllNotAdminUsers < ActiveRecord::Migration
  def up
    p = Purchase.all
    puts 'DELETE Purchase.all'
    p.each do |purchase|
      puts 'purchase id '+purchase.id.to_s
      purchase.destroy
    end
    
    swa = SupplierWithoutAccount.all
    puts 'DELETE SupplierWithoutAccount.all'
    swa.each do |s|
      puts s.image_name
      s.destroy
    end

    puts 'DELETE Subscriber.all'
    subs = Subscriber.all
    subs.each do |s|
      puts s.email
      s.destroy
    end
    
  end

  def down
  end
end
