class Request

  def self.create_cookie(vals)

    if vals.kind_of?(Array)
      cookie = ''

      vals.each do |c|
        cookie += c[:name] + '=' + c[:value] + '; '
      end

      return cookie
    else
      return vals
    end

  end

end
