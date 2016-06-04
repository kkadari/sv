require 'bridge_helper'

describe 'Get an Incident Report by ID' do

  before do
    payload = '{
        "body": "BRIDGE Incident Report",
        "handlingLevel": "This is an Incident Report created via the bridge API tests.",
        "incidentCategory": "GREEN",
        "title": "EXERCISE_NETWORK_DEFENSE_TESTING"
      }'
    @id = IncidentReports.post_ir(payload, @authorisation)['id']
    @response = IncidentReports.get_ir(@id, @authorisation)
  end

  it 'returns a 200 HTTP status' do
    assert_code_and_body(@response, 200)
  end

  it 'returns the right incident report' do
    # TODO: Improve checks.
    fail 'No content found.' unless !JSON.parse(@response).nil?
  end

  it 'returns a 404 HTTP status if the requested incident report does not exist' do
    id = @id + '-0001' # false ID
    response = IncidentReports.get_ir(id, @authorisation)
    assert_code_and_body(response, 404)
    fail 'No content found.' unless !JSON.parse(response).nil?
  end

  xit 'returns a schema compliant response' do
    # TODO
  end

end