require 'spec_helper'

describe 'Comment actions' do

  it 'should return a 200 when requesting all the comments for a piece of content' do
    payload = IncidentReportPayload.new('API Check test - ' + Time.now.to_s, false, 'Lorem ipsumy goodness', 'amber',{:type => 'community'},'',false).payload
    response = CreateContent.create_incident_report(payload, @authorisation)
    incident_id = response['redirect'][/[0-9]+/,0]

    RestClient.get(ENV['base_url'] + '/comment-list.jspa?location=jive-comments&mode=comments&isPrintPreview=false&object=' + incident_id + '&contentObjectType=11111&start=0&numResults=25&sort=datedesc',{:cookie => @authorisation, 'X-Requested-With' =>'XMLHttpRequest'}){|response|

      assert_code_and_body(response, 200)
    }
  end

end
