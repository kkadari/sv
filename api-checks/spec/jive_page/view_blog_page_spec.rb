require 'spec_helper'

describe 'View blog page' do

  it 'should return a 200 when requesting to view a blog' do
    @subject = 'Automation ' + Time.now.to_s()
    payload = BlogPayload
                  .new(@subject,
                       'Content goes here',
                       'red',
                       'test1, test2, test3',
                       'Admin').payload

    response = CreateContent.post_blog(payload, @authorisation)
    @blog_url = JSON.parse(response.body)['redirect']

    RestClient.get(ENV['base_url'] + @blog_url, {:cookie => @authorisation, :content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

end
