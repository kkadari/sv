require 'spec_helper'

describe 'View blog page' do

  it 'should return a 200 when requesting to view a blog' do
    RestClient.get(ENV['base_url'] + '/blogs/hero-banner/2015/06/23/hero-banner-config',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end