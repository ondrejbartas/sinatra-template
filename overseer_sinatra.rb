# -*- encoding : utf-8 -*-
require 'sinatra'
require 'sinatra/base'
require 'erb'

#including Sinatra methods
Dir[File.join(File.dirname(__FILE__),"/app_sinatra/*.rb")].each {|file| require file }

def get_or_post(path, opts={}, &block)
  get(path, opts, &block)
  post(path, opts, &block)
end  

#Method for generating standart looking output
def render_output name = nil, items = nil
  content_type :json

  #compose output JSON
  output = {:status => "ok", :executed_at => Time.now.strftime("%Y-%m-%d %H:%M:%S"), :message => "ok"}
  
  #items and name specified
  return JSON.pretty_generate(output.merge({ name => items })) if name && items

  #name specified
  return JSON.pretty_generate(output.merge({ :output => name })) if name

  #only response with ok message
  return JSON.pretty_generate(output)
end

class OverseerSinatra < Sinatra::Base
  set :views, File.dirname(__FILE__) + '/app_sinatra/views'
  set :show_exceptions, false
    
  error do
    content_type :json
    
    #Change error code based on Exception class
    error_code = 500
    error_code = 400 if env["sinatra.error"].class == ArgumentError
    
    #compose output JSON
    output = {:status => "error", :executed_at => Time.now.strftime("%Y-%m-%d %H:%M:%S"), :message => env["sinatra.error"].message}
    
    #allow to show backtrace on development and test environment
    output[:backtrace] = env["sinatra.error"].backtrace if ["test", "development"].include?(ENV['RACK_ENV'])
    
    halt error_code, JSON.pretty_generate(output)
  end
  
end
