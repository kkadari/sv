require 'spec_helper'

describe 'User bookmarks page' do

  it 'should return a 200 when requesting bookmark page' do
    RestClient.get(ENV['base_url'] + '/people/admin/bookmarks',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

end
