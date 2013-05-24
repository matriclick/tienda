class	PhoneNumberValidator < ActiveModel::EachValidator
	def validate_each(record, attribute, value)
		unless value.blank?
			record.errors[attribute] << (options[:message] || "is invalid") if /\A[+]?[(\s|\d)]+$/.match(value).to_s.blank?
		end
	end
end