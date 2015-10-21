module Login

  def self.do_login(username, password)
    payload = 'username=' + CGI.escape(username) + '&password=' + CGI.escape(password)

    RestClient.post(ENV['base_url'] + '/cs_login', payload, :content_type => 'application/x-www-form-urlencoded'){|response|
      response.headers[:set_cookie].each do |cookie|
        @token = cookie.scan(/=.*;\s/)[0].gsub(';','') if cookie.include? 'jive.security.context'
      end

      c = CGI::Cookie::parse(response.headers[:set_cookie].join(','))

      authorisation = 'jive.login.ts=' + c['jive.login.ts'][0] + '; ' +
          'jive.login.type=' + c['jive.login.type'][0] + '; ' +
          'jive.user.loggedIn=' + c['jive.user.loggedIn'][0] + '; ' +
          'jive.server.info=' + c['jive.server.info'][0] + '; ' +
          'jive.security.context' + @token

      return authorisation
    }
  end

end