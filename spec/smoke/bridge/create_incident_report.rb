require 'bridge_helper'

describe 'Create a new Incident Report' do

  before do
    payload = '{
        "body": "BRIDGE Incident Report",
        "handlingLevel": "This is an Incident Report created via the bridge API tests.",
        "incidentCategory": "GREEN",
        "title": "EXERCISE_NETWORK_DEFENSE_TESTING"
      }'
    @response = IncidentReports.post_ir(payload, @authorisation)
  end

  it 'returns a 200 HTTP status' do
    assert_code_and_body(@response, 201)
  end

  it 'returns the newly created incident report object' do
    # TODO
    @id = @response['id'] # re-use this ID
  end

  xit 'returns a schema compliant response' do
    # TODO
  end

end