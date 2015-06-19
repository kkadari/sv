require 'spec_helper'

describe 'Rating widget' do

  it 'should return a 200 when posting a document rating' do
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/rating/18/1821','4',{:cookie => @authorisation, :content_type => 'application/x-www-form-urlencoded'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting the current document rating' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/rating/18/1821',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end