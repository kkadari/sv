require 'rest-client'
require 'require_all'
require 'base64'
require 'faker'
require 'cgi/cookie'
require 'json'
require 'nokogiri'
require_all File.dirname(__FILE__) + '/../lib/'

RSpec.configure do |config|
  config.before(:all) do
    puts 'Logging in as: ' + ENV['username']

    @authorisation = Login.do_login(ENV['username'], ENV['password'])

    # Lets start building params

    RestClient.get(ENV['base_url'] + '/api/core/v3/people/username/' + ENV['username'],:cookie => @authorisation){ |response|
      @id = JSON.parse(response.body.split(';',0)[1])['id'].to_s
    }

    RestClient.get(ENV['base_url'] + '/api/core/v3/people/username/' + ENV['username_2'],:cookie => @authorisation){ |response|
      @user_2_id = JSON.parse(response.body.split(';',0)[1])['id'].to_s
    }

    20.times do |i|
      RestClient.get(ENV['base_url'] + '/api/core/v3/streams/' + i.to_s,:cookie => @authorisation){|response|
        if response.code == 200
          @stream_id = i.to_s
          break
        end
      }
    end

    RestClient.get(ENV['base_url'] + '/api/core/v3/places?filter=search(' + ENV['space'] + ')',:cookie => @authorisation){|response|
      @space_id = JSON.parse(response.body.split('\';')[1])['list'][0]['id']
    }

    RestClient.get(ENV['base_url'] + '/api/core/v3/places?filter=search(' + ENV['group'] + ')',:cookie => @authorisation){|response|
      @group_id = JSON.parse(response.body.split('\';')[1])['list'][0]['id']
    }
  end

  config.before(:each) do
    @t1 = Time.now
  end

  config.after(:each) do
    puts 'Test time: ' + (Time.now - @t1).to_s
  end

  def assert_code_and_body(response, status_code)
    fail('Error detected in response body') if response.body.include?('The item does not exist. It may have been deleted.') || response.body.include?(' An unexpected error has occurred')
    fail('Failed with ' + response.code.to_s) if response.code != status_code
  end

end
