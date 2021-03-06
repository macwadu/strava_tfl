$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'public/'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'

Bundler.require :default, ENV['RACK_ENV']

Dir[File.expand_path('../../app/helpers/*.rb', __FILE__)].each do |f|
  require f
end

# load helpers before api
Dir[File.expand_path('../../api/v1/helpers/*.rb', __FILE__)].each do |f|
  require f
end

Dir[File.expand_path('../../api/*.rb', __FILE__)].each do |f|
  require f
end

CONFIG_FILE = YAML.load(File.read("#{File.join(File.dirname(__FILE__), '..', 'config')}/conf.yml"))
CONFIG_FILE["authentication"]["client_secret"] = ENV["STRAVA_API_SECRET"]

require 'api'
