require 'spec_helper'

describe 'Request a group widget' do

=begin
  it 'should return a 200 when requesting the widget app' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/createmenu?containerType=14&containerID=1',:cookie => @authorisation){|response|
      @instance_id = JSON.parse(response)['sections'][2]['items'][0]['appInstanceUUID']
    }

    RestClient.get(ENV['base_url'] + '/__services/v2/rest/apps/v1/instances/appinstance/' + @instance_id,:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end
=end

end
