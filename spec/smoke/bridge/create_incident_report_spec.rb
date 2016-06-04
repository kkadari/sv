require 'bridge_helper'

describe 'Create a new Incident Report' do

  schema = {
      "type" => "object",
      "properties" => {
          "body" => {"type" => "string"},
          "handlingLevel" => {"type" => "string"},
          "id" => {"type" => "string"},
          "incidentCategory" => {"type" => "string"},
          "title" => {"type" => "string"}
      }
  }

  before do
    payload = '{
        "body": "This is an Incident Report created via the bridge API tests.",
        "handlingLevel": "GREEN",
        "incidentCategory": "EXERCISE_NETWORK_DEFENSE_TESTING",
        "title": "BRIDGE Incident Report"
    }'
    @response = IncidentReports.create_ir(payload, @authorisation)
  end

  it 'returns a 201 HTTP status' do
    assert_code_and_body(@response, 201)
  end

  it 'returns the newly created incident report object' do
    # TODO - Improve checks.
    @id = @response['id'] # re-use this ID
  end

  it 'returns a schema compliant response' do
    fail 'Schema failed validation.' unless JSON::Validator.validate(schema, @response, :strict => true)
  end

end