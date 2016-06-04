require 'bridge_helper'

describe 'Get all Incident Reports' do

  before do
    @response = IncidentReports.get_irs(@authorisation)
  end

  it 'returns a 200 HTTP status' do
    assert_code_and_body(@response, 200)
  end

  it 'returns incident report objects' do
    fail 'No content found.' unless !@response.nil? # Improve check that IRs are actually returned.
  end

  xit 'returns a schema compliant response' do
    # TODO
  end

end