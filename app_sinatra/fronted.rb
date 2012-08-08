# -*- encoding : utf-8 -*-
class AskmeSinatra < Sinatra::Base
  
  get '/' do
    erb :index
  end
  
end
