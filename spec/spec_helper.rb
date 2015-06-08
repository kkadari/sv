require 'rest-client'
require 'base64'
require 'faker'

RSpec.configure do |config|
  config.before(:all) do
    @authorisation = 'Basic ' + Base64.encode64(ENV['username'] + ':' + ENV['password'])
  end
end