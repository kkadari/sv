require 'spec_helper'

describe 'Incident report' do

  before(:all) do
    payload = IncidentReportPayload
                  .new('Testing builder 2',
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

  it 'should return a 200 when requesting an incident report' do
    RestClient.get(ENV['base_url'] + '/incidentreports/' + @document_id,{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end