# -*- encoding : utf-8 -*-
class OverseerSinatra < Sinatra::Base
  
  get '/is_alive' do
    render_output :hello_message, "Oh yeah Baby! Overseer is alive :-)"
  end

  get '/change_log' do
    erb :change_log
  end

  get '/change_log.json' do
    render_output :changelog, {:version => APP_VERSION_GIT.version, :logs => APP_VERSION_GIT.changelog}
  end

  get '/' do
    erb :index
  end
  
end
