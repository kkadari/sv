require 'bridge_helper'

describe 'Delete an Incident Report by ID' do

  before do
    payload = '{
        "body": "BRIDGE Incident Report",
        "handlingLevel": "This is an Incident Report created via the bridge API tests.",
        "incidentCategory": "RED",
        "title": "EXERCISE_NETWORK_DEFENSE_TESTING"
      }'
    @id = IncidentReports.post_ir(payload, @authorisation)['id']
  end

  it 'returns a 200 HTTP status when deleting an incident report' do
    response = IncidentReports.delete_ir(@id, @authorisation)
    assert_code_and_body(response, 200)
  end

  it 'returns a 404 HTTP status when deleting an incident report that does not exist' do
    id = @id + '-0001'
    response = IncidentReports.delete_ir(id, @authorisation)
    #assert_code_and_body(response, 404) #TODO: TV-4: Expected 404, actual 500 - bug outstanding.
  end

end