class AddBasicPrivileges < ActiveRecord::Migration
  def up
    puts "--> StoreAdminPrivilege:"
    aux = []
    aux << (StoreAdminPrivilege.find_by_name("Administrar Stock") || StoreAdminPrivilege.create(:name => 'Administrar Stock'))
    aux << (StoreAdminPrivilege.find_by_name("Crear Productos") || StoreAdminPrivilege.create(:name => 'Crear Productos'))
    aux << (StoreAdminPrivilege.find_by_name("Ver Pagos de Tramanta") || StoreAdminPrivilege.create(:name => 'Ver Pagos de Tramanta'))
    aux << (StoreAdminPrivilege.find_by_name("Usar Punto de Venta") || StoreAdminPrivilege.create(:name => 'Usar Punto de Venta'))
    aux << (StoreAdminPrivilege.find_by_name("Ver Reportes") || StoreAdminPrivilege.create(:name => 'Ver Reportes'))
    aux << (StoreAdminPrivilege.find_by_name("Administrar Usuarios") || StoreAdminPrivilege.create(:name => 'Administrar Usuarios'))
    aux.each { |x| puts x.name }
    puts "\n"
    
    users = User.where('role_id = 2')
    users.each do |u|
      u.store_admin_privileges.delete StoreAdminPrivilege.all
      u.store_admin_privileges << StoreAdminPrivilege.find_by_name("Administrar Stock")
      u.store_admin_privileges << StoreAdminPrivilege.find_by_name("Ver Pagos de Tramanta")
    end
    users = User.where('email like "%hhanckes%"')
    users.each do |u|
      u.store_admin_privileges.delete StoreAdminPrivilege.all
      u.store_admin_privileges << StoreAdminPrivilege.find_by_name("Administrar Stock")
      u.store_admin_privileges << StoreAdminPrivilege.find_by_name("Ver Pagos de Tramanta")
      u.store_admin_privileges << StoreAdminPrivilege.find_by_name("Administrar Usuarios") 
    end
  end

  def down
  end
end
