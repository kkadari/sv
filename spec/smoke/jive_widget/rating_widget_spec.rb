require 'spec_helper'

describe 'Rating widget' do

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

  it 'should return a 200 when posting a document rating' do
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/rating/11111/' + @document_id,'4',{:cookie => @authorisation, :content_type => 'application/x-www-form-urlencoded'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting the current document rating' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/rating/11111/' + @document_id,:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end