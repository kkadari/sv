require 'net/http'

module Request
  include FigNewton

  # Allows you to create an incident report via the REST endpoint
  # Params:
  # +cookies+:: Array<Hash> - Expects an array of cookies that can be taken from an active WebDriver session using @browser.cookies.to_a
  # +subject+:: String - Expects a standard string to set the subject of the report
  # +body+:: String - Expects a standard string (which may include html tags) and will wrap them in <body><p></p></body> to form the body of the report
  # +handling_level+:: String - Expects a string that is converted into a number.  Allowed combinations are red, amber, green, white and random.
  # +publication+:: Hash - Expects one of three different types to set who to publish the report to.  They are:
  #                        Community, Private group, Secret group = Hash[:type => 'community']
  #                        Space                                  = Hash[:type => 'space',:users => 'user1@test,user2@test'] - Note that each user you want is comma separated
  # +tags+:: String - Expects a standard string to create tags.  To create more than one tag they should be comma separated
  # +anonymous_flag+:: Boolean - Expects a boolean flag to set whether the report will be anonymous or not
  def self.create_incident_report(cookies,subject,body,handling_level,publication,tags,anonymous_flag)
    uri = URI("#{FigNewton.base_url}/__services/v2/rest/incidentReports/")
    http = Net::HTTP.new(uri.host, 80)
    cookie = ""

    cookies.each do |c|
      cookie += c[:name] + "=" + c[:value] + "; "
    end

    headers = {
        'Cookie' => cookie,
        'Content-Type' => 'application/json; charset=UTF-8'
    }

    payload = '{
      "mobileEditor":"false",
      "cancelURL":"/welcome",
      "jive":{
        "token":{
          "name":"jive.token.content.incidentReport.create",
          "content":{
            "incidentReport":{
              "create":"1429181877828-6KCQ4IC56UXFGVIBZYA519CZSDP9J3H2"
            }
          }
        }
      },
      "subject":"' + subject + '",
      "body":"<body><p>' + body + '</p></body>",
      "handlingLevel":"' + set_ihm_level(handling_level) + '",
      "publishBar":' + set_publish_bar(publication) + ',
      "moveNotifyStreams":false,
      "tags":"' + tags + '",
      "notAttributable":' + anonymous(anonymous_flag) + ',
      "draft":"false",
      "draftID":"1038",
      "jiveTokenName":"jive.token.content.incidentReport.create"
    }'

    resp, data = http.post(uri.path, payload, headers)
    return resp.code
  end

  private

  def self.set_ihm_level(color)
    case color
      when 'red'
        return '1'
      when 'amber'
        return '2'
      when 'green'
        return '3'
      when 'white'
        return '4'
      when 'random'
        %w(1 2 3 4).sample
      else
        fail "Allowed combinations are red, amber, green, white and random.  You chose: #{color}"
    end
  end

  def self.set_publish_bar(publication)
    case publication[:type]
      when 'community'
        return '{"visibility":"all"}'
      when 'space'
        return '{"visibility":"people","users":"' + publication[:users] + '"}'
      when 'private group'
        return '{"visibility":"place","container":{"objectType":"700","objectID":"1004"}}'
      when 'secret group'
        return '{"visibility":"place","container":{"objectType":"700","objectID":"1005"}}'
      else
        fail "Allowed publications are community, private group, secret group and space.  You chose: #{publication[:type]}"
    end
  end

  def self.anonymous(anonymous_flag)
    if anonymous_flag
      return "true"
    else
      return "false"
    end
  end

end