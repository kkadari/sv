class Request

  def self.create_cookie(vals)
    cookie = ''

    vals.each do |c|
      cookie += c[:name] + '=' + c[:value] + '; '
    end

    return cookie
  end


end