require 'spec_helper'

describe 'Incident report' do

  it 'should return a 200 when requesting an incident report' do
    RestClient.get(ENV['base_url'] + '/incidentreports/4430',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end