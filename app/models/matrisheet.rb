class Matrisheet

  def self.upload(data)
    name = Time.now.to_s+' '+data.original_filename
    # create the file path
    dir = FileUtils.mkdir_p("public/tmp")
    path = File.join dir, name
    # write the file
    File.open(path, 'wb') do |f|
      f.write(data.read)
    end
		Rails.logger.info ">>>>>> PATH"
		Rails.logger.info path
    return path
  end

  def self.import(file, user_account) 
		Rails.logger.info ">>>>> IMPORTING..."
		Rails.logger.info ">>>>> FILE:"
		Rails.logger.info file
		Rails.logger.info ">>>>> USERACCOUNT"
		Rails.logger.info user_account.to_json
		
		Spreadsheet.client_encoding = 'UTF-8'
		
		#Open file, rescues if fails
    begin
		book = Spreadsheet.open file
		rescue
		File.delete(file)
		return false 
		end
		#default worksheet
		sheet = book.worksheet 0
		#read every cell	
		sheet.each 1 do |row|
			name = row[0]
			lastname_p = row[1]
			lastname_m = row[2]
			age = Age.find_by_range(row[3])
			gender = Gender.find_by_gender(row[4])
			couple = Couple.find_by_name(row[5])
			group = InviteeGroup.find_or_create_by_name(row[6])
			status = Status.find_by_status(row[7])
			host = InviteeHost.find_by_name(row[8])
			role = InviteeRole.find_by_name(row[9])
			confirmed = row[10] == "Si"
			email = row[11]
			phone_number = row[12].to_s
			address_street = row[13]
			address_number = row[14].to_s
			address_region = Region.find_by_name(row[15])
			address_commune = Commune.find_by_name(row[16])
			
#Creates and saves invitee
			address = Address.new(
        :street=>address_street,
        :number=>address_number,
        :region=>address_region,
				:commune=>address_commune)
      address.save
      invitee = Invitee.new(
        :name=>name,
        :lastname_p=>lastname_p,
        :lastname_m=>lastname_m, 
        :phone_number=>phone_number,
        :email=>email,
        :confirmed=>confirmed,
        :gender=>gender,
        :age=>age,
        :status=>status,
        :address=>address,
       	:couple =>couple,
        :invitee_group=>group,
				:invitee_host=>host,
				:invitee_role=>role,
				:user_account_id => user_account.id)
			if invitee.save
				Rails.logger.info ">>>> INVITEE"
				Rails.logger.info invitee.to_json
			end

		end
		File.delete(file)
		return true		
	end


	def self.export (user_account)

		name = Time.now.to_s+' '+ "invitados.xls"
    # create the file path
    dir = FileUtils.mkdir_p("public/tmp")
    path = File.join dir, name
	
		invitees = Invitee.where(:user_account_id => user_account.id)
		
    #Create spreadsheet
		book = Spreadsheet::Workbook.new
		sheet = book.create_worksheet
		
		#Headers
		sheet[0,0] = "Nombres"
		sheet[0,1] = "Apellido Paterno"
		sheet[0,2] = "Apellido Materno"
		sheet[0,3] = "Edad"
		sheet[0,4] = "Genero"
		sheet[0,5] = "Pareja"
		sheet[0,6] = "Grupo"		
		sheet[0,7] = "Invitado a"	
		sheet[0,8] = "Invitado por"	
		sheet[0,9] = "Rol"
		sheet[0,10] = "Confirmado"		
		sheet[0,11] = "Correo electronico"
		sheet[0,12] = "Telefono"
		sheet[0,13] = "Direccion"
		sheet[0,14] = "Numero"
		sheet[0,14] = "Region"
		sheet[0,16] = "Comuna"
		
		
		#Fill in invitees info
		i = 1
		invitees.each do |inv|
			sheet[i,0] = inv.name	
			sheet[i,1] = inv.lastname_p
			sheet[i,2] = inv.lastname_m
			sheet[i,3] = inv.age.range if inv.age.present?
			sheet[i,4] = inv.gender.gender if inv.gender.gender?
			sheet[i,5] = inv.couple.name if inv.couple.present?
			sheet[i,6] = inv.invitee_group.name if inv.invitee_group.present?
			sheet[i,7] = inv.status.status if inv.status.present?
			sheet[i,8] = inv.invitee_host.name if inv.invitee_host.name.present?
			sheet[i,9] = inv.invitee_role.name if inv.invitee_role.present?
			sheet[i,10] = (inv.confirmed ? "Si":"No")	
			sheet[i,11] = inv.email
			sheet[i,12] = inv.phone_number	
			sheet[i,13] = inv.address.street	if inv.address.street.present?
			sheet[i,14] = inv.address.number if inv.address.number.present?
			sheet[i,15] = inv.address.region.name if inv.address.region.present?
			sheet[i,16] = inv.address.commune.name if inv.address.commune.present?
			i+=1			
		end

		#Style
		header = Spreadsheet::Format.new :text_wrap => true, :horizontal_align => :left , :weight => :bold 
		data = Spreadsheet::Format.new :horizontal_align => :left, :text_wrap => true
		sheet.row(0).default_format = header
		1.upto(12) do |r|
			sheet.row(r).default_format = data
		end

		#save and return
		book.write path
		return path
	end

end
