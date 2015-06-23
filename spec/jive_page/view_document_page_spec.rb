require 'spec_helper'

describe 'Document page' do

  it 'should return a 200 when requesting the page' do
    RestClient.get(ENV['base_url'] + '/docs/DOC-1101',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end