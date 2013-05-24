class Analytics 
	extend Garb::Model

	metrics :pageviews
	dimensions :page_path, :month, :year
end