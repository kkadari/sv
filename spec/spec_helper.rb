require 'rest-client'
require 'require_all'
require 'base64'
require 'faker'
require 'cgi/cookie'
require_all File.dirname(__FILE__) + '/../lib/content_payloads/'

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
  end

  config.before(:each) do
    @t1 = Time.now
  end

  config.after(:each) do
    puts 'Test time: ' + (Time.now - @t1).to_s
  end
end