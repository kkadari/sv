require 'spec_helper'

describe 'Like widget' do

  before(:all) do
    payload = IncidentReportPayload
                  .new('Shared feed items test',
                       false,
                       'body content goes here',
                       'red',
                       Hash[:type => 'community'],
                       'test, test2',
                       false).payload

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/incidentReports/',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      @document_id = response.body.scan(/reports\/[0-9]*/)[0].split('/')[1]
    }
  end

  it 'should return a 200 when requesting the like list of a piece of content' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/activity/users/like/11111/' + @document_id + '?count=20&start=0&_=1434966527868',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

end
