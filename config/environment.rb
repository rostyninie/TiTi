# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
TiTiNew::Application.initialize!
#TiTiNew::Application.initializer.run do |config|
gem "declarative_authorization", :source => "http://gemcutter.org"
#end