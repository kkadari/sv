class PeoplePayload < Payload

  def initialize(username, password)
    @username = username
    @password = password
  end

  def payload
    '{
        "emails" : [ {
            "value" : "' + @username + '@surevine.com",
            "type" : "work",
            "primary" : true,
            "jive_label" : "Email"
        } ],
        "jive" : {
            "password" : "password123",
            "username" : "' + @username + '@surevine"
        },
        "name" : {
        "familyName" : "' + @username + '",
        "givenName" : "' + @username + '"
        }
    }'
  end

end
