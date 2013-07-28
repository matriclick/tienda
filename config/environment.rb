# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Matri::Application.initialize!

config.load_paths << "#{RAILS_ROOT}/app/sweepers"