class MatrisheetsController < ApplicationController
before_filter :redirect_unless_user_signed_in
before_filter :authenticate_user!

	def upload
		if params[:matrisheet].present?
      file = Matrisheet.upload(params[:matrisheet][:data])
      succeeded = Matrisheet.import(file, current_user.user_account)
			if succeeded 
				redirect_to invitees_url, :notice => 'Invitees were succesfully imported.' 
			else			
				redirect_to matrisheet_upload_url, :notice=> t('import_error') #Missing errors and translation				
			end				     
    
		else      
    	respond_to do |format|
      	format.html  
    	end
		end
	end

	
	def download
		file = Matrisheet.export(current_user.user_account)
		send_file file
		File.delete(file)				
	end

	def send_base_file
		send_file 'public/files/Lista_invitados_oficial.xls'
		
	end
	

end
