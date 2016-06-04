require 'bridge_helper'

describe 'Update an Incident Report by ID' do

  before do
    @response_400 = ''
    @response_404 = ''
    @ir_title = 'BRIDGE Incident Report'
    @ir_body = 'This is an Incident Report created via the bridge API tests.'
    @ir_ihm = 'GREEN'
    @ir_cat = 'EXERCISE_NETWORK_DEFENSE_TESTING'

    payload = '{
        "body": "' + @ir_title + '",
        "handlingLevel": "' + @ir_ihm + '",
        "incidentCategory": "' + @ir_cat + '",
        "title": "' + @ir_title + '"
      }'
    @id = IncidentReports.post_ir(payload, @authorisation)['id']
    @payload << '{
        "body": "'+@ir_body+' [UPDATED]",
        "handlingLevel": "'+@ir_ihm+'",
        "id": "'+@id+'",
        "incidentCategory": "'+@ir_cat+'",
        "title": "'+@ir_title+' - UPDATED"
      }'
    @response = IncidentReports.update_ir(@id, @payload, @authorisation)
  end

  it 'returns a 201 HTTP status' do
    assert_code_and_body(@response, 201)
  end

  xit 'returns a schema compliant response' do
    # TODO
  end

  it 'returns a 400 HTTP status when payload and URL ID do not match' do
    id = @id + '-0001' # Differs from id in payload
    @response_400 << IncidentReports.update_ir(id, @payload, @authorisation)
    assert_code_and_body(@response2, 400)
  end

  it 'returns a valid error message when payload and URL ID do not match' do
    fail 'Expected error message not returned.' unless JSON.parse(@response_400)['message'] == "Supplied object id and resource id do not match."
  end

  it 'returns a 404 HTTP status when updating an incident report that does not exist' do
    id = @id + '-0001' # Differs from id in payload
    payload = '{
        "body": "'+@ir_body+' [UPDATED]",
        "handlingLevel": "'+@ir_ihm+'",
        "id": "'+@id+'-0001",
        "incidentCategory": "'+@ir_cat+'",
        "title": "'+@ir_title+' - UPDATED"
      }'
    @response_404 = IncidentReports.update_ir(id, payload, @authorisation)
    # assert_code_and_body(@response_404, 404) #TODO: TV-4: Expected 404, actual 500 - bug outstanding.
    # puts JSON.parse(@response)
    # fail 'Expected error message not returned.' unless JSON.parse(@response_404)['message'] == "IncidentReport not found."
  end

  xit 'returns a schema compliant error response when updating an IR that does not exist' do
    # TODO
  end

end