require 'rest-client'
require 'base64'

RSpec.configure do |config|
  config.before(:all) do
    @authorisation = 'Basic ' + Base64.encode64('markw@surevine:Grg@!6KsS1EY7Bb')
  end
end