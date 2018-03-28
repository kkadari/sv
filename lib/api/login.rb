require 'rest-client'
require 'require_all'
require 'base64'
require 'faker'
require 'cgi/cookie'
require 'json'
require 'nokogiri'
require_all File.dirname(__FILE__) + '/..'

module Login

  def self.do_totp_login(username, password, totp_secret)
    #payload = 'username=' + CGI.escape(username) + '&password=' + CGI.escape(password)

    # Change login to use 2FA screens here.

    # Get TOTP key for user
    totp = ROTP::TOTP.new(totp_secret)
    totp.now

    puts 'totp: username: ' + username + ', password: ' + password + '(token: ' + totp.new + ')'

    # Do login here...
  end

  ENV['base_url'] = 'http://dev188.sure.vine/'

  puts 'Environment:' + ENV['base_url']

  def self.do_login(username, password)
    payload = 'username=' + CGI.escape(username) + '&password=' + CGI.escape(password)
    #puts payload

    RestClient.post(ENV['base_url'] + '/cs_login', payload, :content_type => 'application/x-www-form-urlencoded'){|response|
      response.headers[:set_cookie].each do |cookie|
        @token = cookie.scan(/=.*;\s/)[0].gsub(';','') if cookie.include? 'jive.security.context'
       # puts cookie
      end
     #puts response.headers
      c = CGI::Cookie::parse(response.headers[:set_cookie].join(','))
 #    for key in c.keys()
 #       print key, " = ", c[key][0], "\n"
 #     end

     #puts c['jive.login.ts'][0]
      #puts c['jive.login.type'][0]

      authorisation = 'jive.login.ts=' + c['jive.login.ts'][0] + '; ' +
         'jive.login.type=' + c['HttpOnly,jive.login.type'][0] + '; ' +
          'jive.user.loggedIn=' + c['HttpOnly,jive.user.loggedIn'][0] + '; ' +
          'jive.server.info=' + c['HttpOnly,jive.server.info'][0] + '; ' +
          'jive.security.context' + @token + '; '
          #'jive.security.context' + c['HttpOnly,jive.security.context'][0] + '; '
      #puts authorisation

      RestClient.get(ENV['base_url'] + '/api/core/v3/people/@me',:cookie => @authorisation){ |response|
        authorisation += 'X-JCAPI-Token' + response.headers[:set_cookie][1].scan(/=.*;\s/)[0].gsub(';','');
      }
      #puts authorisation

      return authorisation
    }
  end

  def self.get_user_id(cookies)
    RestClient.get(ENV['base_url'] + '/api/core/v3/people/@me', :cookie => Request.create_cookie(cookies)){|response|
      fail('User ID not found') unless JSON.parse(response.split(';',0)[1])['id'].present? || response.code != 200
      user_id = JSON.parse(response.split(';',0)[1])['id']

      return user_id
    }
  end


  #do_login('admin', 'admin')

end
