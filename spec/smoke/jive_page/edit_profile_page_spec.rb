require 'spec_helper'

describe 'Edit profile page' do

  it 'should return a 200 when requesting the edit profile page' do
    RestClient.get(ENV['base_url'] + '/edit-profile!input.jspa?targetUser=' + @id,:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 302 when sending a request to update the profile' do
    RestClient.get(ENV['base_url'] + '/edit-profile!input.jspa?targetUser=' + @id,:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)

      @token = response.body.scan(/edit.profile.[0-9]*" value=".*"/)[0].split('="')[1].gsub('"','')
    }

    payload = ProfilePayload.new(
        Faker::Name.prefix,
        Faker::PhoneNumber.phone_number,
        Faker::PhoneNumber.phone_number,
        Faker::Internet.email,
        Faker::Lorem.sentence,
        ENV['username'],
        @id,
        @token
    ).payload

    RestClient.post(ENV['base_url'] + '/edit-profile.jspa',payload,:cookie => @authorisation){|response|
      assert_code_and_body(response, 302)
    }
  end

end