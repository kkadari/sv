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

  # Log failures so we can re-run them.
  config.example_status_persistence_file_path = File.dirname(__FILE__) + '/../reports//failures.txt'

  config.before(:all) do
    puts 'Logging in as: ' + ENV['username']

    @authorisation = Login.do_login(ENV['username'], ENV['password'])

    # RestClient.log = 'stdout' #uncomment to debug

    # Get User 1 ID from the specified user
    RestClient.get(ENV['base_url'] + '/api/core/v3/people/username/' + ENV['username'],:cookie => @authorisation){ |response|
      @id = JSON.parse(response.body.split(';',0)[1])['id'].to_s
    }

    # Get User 2 ID from the specified user
    if !ENV['username_2'].nil?
      RestClient.get(ENV['base_url'] + '/api/core/v3/people/username/' + ENV['username_2'],:cookie => @authorisation){ |response|
        @user_2_id = JSON.parse(response.body.split(';',0)[1])['id'].to_s
      }
    end

    # Get connection stream ID (used by Inbox and Feeds)
    RestClient.get(ENV['base_url'] + '/api/core/v3/people/' + @id + '/streams',:cookie => @authorisation){|response|
      @stream_id = JSON.parse(response.body.split(';',0)[1])['list'][0]['id'].to_s
    }

    # Get Space ID from the specified space
    if !ENV['space'].nil?
      RestClient.get(ENV['base_url'] + '/api/core/v3/places?filter=search(' + ENV['space'] + ')',:cookie => @authorisation){|response|
        @space_id = JSON.parse(response.body.split('\';')[1])['list'][0]['id']
      }
    end

    # Get Group ID from the specified group
    if !ENV['group'].nil?
      RestClient.get(ENV['base_url'] + '/api/core/v3/places?filter=search(' + ENV['group'] + ')',:cookie => @authorisation){|response|
        @group_id = JSON.parse(response.body.split('\';')[1])['list'][0]['id']
      }
    end
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
