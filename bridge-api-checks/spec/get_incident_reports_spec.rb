require 'spec_helper'

describe 'Get all Incident Reports' do

  schema = {
      "type" => "array",
      "items" => {
          "type" => "object",
          "properties" => {
              "body" => {"type" => "string"},
              "handlingLevel" => {"type" => "string"},
              "id" => {"type" => "string"},
              "incidentCategory" => {"type" => ["string", "null"] },
              "title" => {"type" => "string"}
          }
      }
  }

  before do
    @response = IncidentReports.get_irs(@authorisation)
  end

  it 'returns a 200 HTTP status' do
    assert_code_and_body(@response, 200)
  end

  it 'returns incident report objects' do
    fail 'No content found.' unless !@response.nil? # Improve check that IRs are actually returned.
  end

  it 'returns a schema compliant response' do
    fail 'Schema failed validation.' unless JSON::Validator.validate(schema, @response, :strict => true)
  end

end
