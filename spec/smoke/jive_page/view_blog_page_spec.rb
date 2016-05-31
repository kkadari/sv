require 'spec_helper'

describe 'View blog page' do

  it 'should return a 200 when requesting to view a blog' do
    RestClient.get(ENV['base_url'] + '/blogs/hero-banner/2016/02/24/hero-banner-config',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

end
