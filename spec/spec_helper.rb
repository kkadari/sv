require 'rest-client'
require 'require_all'
require 'base64'
require 'faker'
require 'cgi/cookie'
require 'json'
require_all File.dirname(__FILE__) + '/../lib/'

RSpec.configure do |config|
  config.before(:all) do
    payload = 'username=' + CGI.escape(ENV['username']) + '&password=' + CGI.escape(ENV['password'])

    puts 'Logging in as: ' + ENV['username']

    RestClient.post(ENV['base_url'] + '/cs_login',payload){ |response|
      response.headers[:set_cookie].each do |cookie|
        @token = cookie.scan(/=.*;\s/)[0].gsub(';','') if cookie.include? 'jive.security.context'
      end

      c = CGI::Cookie::parse(response.headers[:set_cookie].join(','))

      @authorisation = 'jive.login.ts=' + c['jive.login.ts'][0] + '; ' +
                       'jive.login.type=' + c['jive.login.type'][0] + '; ' +
                       'jive.user.loggedIn=' + c['jive.user.loggedIn'][0] + '; ' +
                       'jive.server.info=' + c['jive.server.info'][0] + '; ' +
                       'jive.security.context' + @token
    }

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
end