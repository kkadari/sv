require 'spec_helper'
require 'logger'

log = Logger.new(STDOUT)
log.level = Logger::DEBUG

describe 'Create users' do

  it 'should return a 201 when creating a new user' do
    response = People.create_new_user('timlol@surevine', 'password', 'tim.durden+lol@surevine', 'Tim', 'Test LOL')
    log.info 'response: ' + response
  end

end
