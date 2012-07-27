# config.ru
require './overseer_app.rb'
require './overseer_sinatra.rb'

# Map applications
run Rack::URLMap.new \
  "/"       => OverseerSinatra.new
