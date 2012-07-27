# -*- encoding : utf-8 -*-
ENV['RACK_ENV'] = "test"

require 'rack/test'
require 'test/unit'
require 'turn'
require 'shoulda-context'

require 'bundler'
Bundler.setup

require './overseer_app'
require './overseer_sinatra'
