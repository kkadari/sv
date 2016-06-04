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
    @ir_title = 'BRIDGE Incident Report'
    @ir_body = 'This is an Incident Report created via the bridge API tests.'
    @ir_ihm = 'GREEN'
    @ir_cat = 'EXERCISE_NETWORK_DEFENSE_TESTING'
    payload = '{
      "body": "' + @ir_body + '",
      "handlingLevel": "' + @ir_ihm + '",
      "incidentCategory": "' + @ir_cat + '",
      "title": "' + @ir_title + '"
    }'
    @response = IncidentReports.create_ir(payload, @authorisation)
  end

  it 'returns a 201 HTTP status' do
    assert_code_and_body(@response, 201)
  end

  it 'returns the newly created incident report object' do
    json = JSON.parse(@response)
    fail 'Response did not contain expected "title".' unless json['title'] == @ir_title
    fail 'Response did not contain expected "body".' unless json['body'] == @ir_body
    fail 'Response did not contain expected "handlingLevel".' unless json['handlingLevel'] == @ir_ihm
    fail 'Response did not contain expected "incidentCategory".' unless json['incidentCategory'] == @ir_cat
    fail 'Response did not contain an ID.' unless !json['id'].nil?
  end

  it 'returns a schema compliant response' do
    fail 'Schema failed validation.' unless JSON::Validator.validate(schema, @response, :strict => true)
  end

end