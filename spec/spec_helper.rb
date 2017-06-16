require 'rest-client'
require 'require_all'
require 'base64'
require 'faker'
require 'cgi/cookie'
require 'json'
require 'nokogiri'
require_all File.dirname(__FILE__) + '/../lib/'

RSpec.configure do |config|

  config.formatter = :documentation
  config.color = true
  config.tty = true

  config.before(:all) do
    @authorisation = Login.do_login('admin', 'admin')

    # Get User 1 ID from the specified user
    RestClient.get(ENV['base_url'] + '/api/core/v3/people/username/admin',:cookie => @authorisation){ |response|
      @id = JSON.parse(response)['id'].to_s
    }

    # Get User 2 ID from the specified user
    RestClient.get(ENV['base_url'] + '/api/core/v3/search/people?origin=searchpage&filter=search(*)',:cookie => @authorisation){ |response|
      @user_2_id = JSON.parse(response)['list'][0]['id']

      if(@user_2_id == '1')
        payload = PeoplePayload.new("testuser", "password123").payload

        RestClient.post(ENV['base_url'] + '/api/core/v3/people', payload, {:cookie => @authorisation, :content_type => 'application/json'}){|response|
          @user_2_id = JSON.parse(response)['id']
        }
      end
    }

    # Get connection stream ID (used by Inbox and Feeds)
    RestClient.get(ENV['base_url'] + '/api/core/v3/people/' + @id + '/streams',:cookie => @authorisation){|response|
      @stream_id = JSON.parse(response)['list'][0]['id'].to_s
    }

    # Get Space ID from the specified space
    RestClient.get(ENV['base_url'] + '/api/core/v3/places?filter=search(support)&filter=type(space)',:cookie => @authorisation){|response|
      @space_id = JSON.parse(response)['list'][0]['id']
    }

    # Get Group ID from the specified group
    RestClient.get(ENV['base_url'] + '/api/core/v3/places?filter=type(group)',:cookie => @authorisation){|response|
      @group_id = JSON.parse(response)['list'][0]['id']

      @group_name = JSON.parse(response)['list'][0]['displayName']
    }
  end

  config.before(:each) do
    @t1 = Time.now
  end

  config.after(:each) do
    puts 'Test time: ' + (Time.now - @t1).to_s
  end

  def assert_code_and_body(response, status_code)
    fail('Error detected in response body') if response.body.include?('The item does not exist. It may have been deleted.') || response.body.include?(' An unexpected error has occurred') || response.body.include?('The request could not be validated as originating from within the SBS application')
    fail('Failed with ' + response.code.to_s) if response.code != status_code
  end

end
