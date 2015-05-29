require 'spec_helper'

describe 'activity_service_v2' do

  it 'should return 200 when getting users activity' do
    RestClient.get('http://dev188.sure.vine/api/core/v2/activity?limit=100', :Authorization => @authorisation) { |response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end