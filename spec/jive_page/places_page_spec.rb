require 'spec_helper'

describe 'Places view page' do

  it 'should return a 200 when requesting the place page' do
    RestClient.get(ENV['base_url'] + '/places',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting one of the filtered views of places' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/containers?filterGroupID=places&itemViewID=thumb&start=0&numResults=20&filterID=historyarchetype%5Bcontainers%5D&itemView=thumb&userID=2012',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end