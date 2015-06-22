require 'spec_helper'

describe 'More like this widget' do

  it 'should return a 200 when requesting the more like this details' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/morelikethis/102/1201/type/102',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end