require 'spec_helper'

describe 'View poll page' do

  it 'should return a 200 when requesting the poll' do
    RestClient.get(ENV['base_url'] + '/polls/1820',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end