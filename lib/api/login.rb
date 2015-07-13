require 'cgi'

module Login

  def self.do_login(username, password)
    uri = URI("#{ENV['base_url']}/cs_login")
    http = Net::HTTP.new(uri.host, 80)

    headers = {
        'Content-Type' => 'application/x-www-form-urlencoded'
    }

    payload = 'username=' + CGI.escape(username) + '&password=' + CGI.escape(password)

    resp = http.post(uri.path, payload, headers)

    resp['Set-Cookie'].split(', ').each do |cookie|
      return cookie.split(';')[0].split('=')[1] if cookie.include? 'jive.security.context'
    end
  end

end