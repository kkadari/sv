require 'rest-client'
require 'base64'
require 'faker'

RSpec.configure do |config|
  config.before(:all) do
    payload = 'username=' + CGI.escape(ENV['username']) + '&password=' + CGI.escape(ENV['password'])

    RestClient.post('http://dev188.sure.vine/cs_login',payload){ |response|
      @authorisation = response.headers[:set_cookie]
    }
  end
end