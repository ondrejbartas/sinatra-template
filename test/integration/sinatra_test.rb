# -*- encoding : utf-8 -*-
require './test/test_helper'

class OverseerSinatraTest < Test::Unit::TestCase
  include Rack::Test::Methods
  
  def app
      OverseerSinatra.new
  end

  context "Overseer main methods" do
    context "change log" do
      should "responce 200" do
        get '/change_log'
        assert_equal last_response.status, 200
      end
    end

    context "change log json" do
      should "responce 200" do
        get '/change_log.json'
        assert_equal last_response.status, 200
      end
    end

    context "is alive check" do
      should "responce 200" do
        get '/is_alive'
        assert_equal last_response.status, 200
      end
    end

    context "index" do
      should "responce 200" do
        get '/'
        assert_equal last_response.status, 200
      end
    end
  end
end