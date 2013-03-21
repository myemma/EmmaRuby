require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'vcr'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'emma'

VCR.configure do |c|
  c.cassette_library_dir  = 'test/fixtures/vcr_cassettes'
  c.default_cassette_options = { :record => :new_episodes }
  c.hook_into :webmock
end
