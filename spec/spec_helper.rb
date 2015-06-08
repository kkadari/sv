require 'rest-client'
require 'base64'
require 'faker'

RSpec.configure do |config|
  config.before(:all) do
    payload = 'username=' + CGI.escape('markw@surevine') + '&password=' + CGI.escape('Grg@!6KsS1EY7Bb')

    RestClient.post('http://dev188.sure.vine/cs_login',payload){ |response|
      @authorisation = response.headers[:set_cookie]
    }
  end
end