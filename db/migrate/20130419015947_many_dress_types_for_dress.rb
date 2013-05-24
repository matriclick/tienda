class ManyDressTypesForDress < ActiveRecord::Migration
  def up
    if table_exists? 'dresses_dress_types'
      drop_table :dresses_dress_types
    end

    if !(table_exists? 'dress_types_dresses')
      create_table :dress_types_dresses, :id => false do |t|
         t.integer :dress_id
         t.integer :dress_type_id

         t.timestamps
      end
    end
     
     Dress.all.each do |dress|
       dress_type = DressType.find dress.dress_type_id
       puts "--> Tipo: "+dress_type.name
       dress.dress_types << dress_type
       dress.save
       puts "--> # Tipos: "+dress.dress_types.size.to_s
     end
  end

  def down
  end
end
