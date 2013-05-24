# coding: utf-8
class	RutValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		unless value.blank?
			# FGM: Check Digit
			check_digit = value.reverse[0].to_s.capitalize == "K" ? value.reverse[0].to_s.capitalize : value.reverse[0].to_i
			# DZF 2011/09/09: This is to format the rut with only numbers, so validation can work properly with rut-javascript validator.
			if check_digit == "K"		  
			  value = value.gsub /[-]|[.]/, ""
	    else
	  		value = value.gsub /\D|[.]/, ""
	    end
			# FGM: Validate rut without check_digit (chop)
			record.errors[attribute] << (options[:message] || "inválido") unless  [*0..9,'K',0][11-(value.chop.reverse.split'').reduce([0,0]){|x,y|[x[0]+1,x[1]+y.to_i*(x[0]%6+2)]}[1]%11] == check_digit
		end
	end
end
