require './app.rb'
require 'rspec'
require 'rack/test'

set :environment, :test

describe 'The HelloWorld App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "will response 200 OK" do
    get '/'
    last_response.should be_ok
  end
end
