module CountryMethods

  def set_country_id_with_locale
    case I18n.locale
      when :es
        self.country_id = 1
        self.save
      when :esPE
        self.country_id = 3
        self.save
    end
  end

end
