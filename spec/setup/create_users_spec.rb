#require 'spec_helper'
#require 'logger'

#log = Logger.new(STDOUT)
#log.level = Logger::DEBUG

#describe 'Create users' do

  # TODO: Refactor this. ~TD
  #pending 'should return a 401 or 409 when attempting to create a new user' do

    #response = `curl -u admin:admin -H "Content-Type: application/json" -X POST -d '{"emails":[{"value":"tim.durden+lol4@surevine.com","type":"work","primary":true,"jive_label":"Email"}],"jive":{"password":"password","username":"timlol4@surevine"},"name":{"familyName":"Durden-Lol","givenName":"Tim"}}' http://dev114.sure.vine/api/core/v3/people`
    #response_code = JSON.parse(response)['error']['status'].to_s

    #fail unless ((response.include? 'HTTP/1.1 401') or (response.include? 'HTTP/1.1 409'))


    # response = People.create_new_user('timlol@surevine', 'password', 'tim.durden+lol@surevine', 'Tim', 'Test LOL')
    #log.info 'response: ' + response_code
    #log.info 'response: ' + response
  #end

#end
