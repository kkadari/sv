require 'spec_helper'

describe 'Edit profile page' do

  it 'should return a 200 when requesting the edit profile page' do
    RestClient.get(ENV['base_url'] + '/edit-profile!input.jspa?targetUser=' + @id,:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

end
