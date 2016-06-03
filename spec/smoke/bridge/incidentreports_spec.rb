require 'bridge_helper'

describe 'Incident Reports API' do

  before(:all) do   # we want to re-use this variable across tests
    @id = ''
    @payload = ''
    @ir_title = 'BRIDGE Incident Report'
    @ir_body = 'This is an Incident Report created via the bridge API tests.'
    @ir_ihm = 'GREEN'
    @ir_cat = 'EXERCISE_NETWORK_DEFENSE_TESTING'
  end

  it 'should return a 200 when requesting incident report objects' do
    response = IncidentReports.get_irs(@authorisation)
    fail 'No content found.' unless !response.nil? # Improve check that IRs are actually returned.
    # TODO: Check response is schema compliant (see Swagger model definition).
  end

  it 'should return a 201 when posting a new incident report' do
    uid = SecureRandom.uuid
    payload = '{
      "body": "'+@ir_body+'",
      "handlingLevel": "'+@ir_ihm+'",
      "incidentCategory": "'+@ir_cat+'",
      "title": "'+@ir_title+'"
    }'
    response = IncidentReports.post_ir(payload, @authorisation)
    @id << response['id'] # re-use this ID
    # TODO: Check response is schema compliant (see Swagger model definition).
  end

  it 'should return a 200 when requesting an incident report by id' do
    response = IncidentReports.get_ir(@id, @authorisation)
    assert_code_and_body(response, 200)
    fail 'No content found.' unless !JSON.parse(response).nil?
    # TODO: Check response is schema compliant (see Swagger model definition).
  end

  it 'should return a 404 when requesting an incident report that does not exist' do
    id = @id + '-0001' # false ID
    response = IncidentReports.get_ir(id, @authorisation)
    assert_code_and_body(response, 404)
    fail 'No content found.' unless !JSON.parse(response).nil?
    # TODO: Check response is schema compliant (see Swagger model definition).
  end

  it 'should return a 201 when updating an incident report' do
    @payload << '{
      "body": "'+@ir_body+' [UPDATED]",
      "handlingLevel": "'+@ir_ihm+'",
      "id": "'+@id+'",
      "incidentCategory": "'+@ir_cat+'",
      "title": "'+@ir_title+' - UPDATED"
    }'
    response = IncidentReports.update_ir(@id, @payload, @authorisation)
    assert_code_and_body(response, 201)
    # TODO: Check response is schema compliant (see Swagger model definition).
  end

  it 'should return a 400 when updating an incident report with payload and URL ID mismatch' do
    id = @id + '-0001' # Differs from id in payload
    response = IncidentReports.update_ir(id, @payload, @authorisation)
    assert_code_and_body(response, 400)
    fail 'Expected error message not returned.' unless JSON.parse(response)['message'] == "Supplied object id and resource id do not match."
    # TODO: Check response is schema compliant (see Swagger model definition).
  end

  it 'should return a 404 when updating an incident report that does not exist' do
    id = @id + '-0001' # Differs from id in payload
    payload = '{
      "body": "'+@ir_body+' [UPDATED]",
      "handlingLevel": "'+@ir_ihm+'",
      "id": "'+@id+'-0001",
      "incidentCategory": "'+@ir_cat+'",
      "title": "'+@ir_title+' - UPDATED"
    }'
    response = IncidentReports.update_ir(id, payload, @authorisation)
    #assert_code_and_body(response, 404) #TODO: TV-4: Expected 404, actual 500 - bug outstanding.
    #puts JSON.parse(response)
    #fail 'Expected error message not returned.' unless JSON.parse(response)['message'] == "IncidentReport not found."
    # TODO: Check response is schema compliant (see Swagger model definition).
  end

  it 'should return a 200 when deleting an incident report' do
    response = IncidentReports.delete_ir(@id, @authorisation)
    assert_code_and_body(response, 200)
  end

  it 'should return a 404 when deleting an incident report that does not exist' do
    id = @id + '-0001'
    response = IncidentReports.delete_ir(id, @authorisation)
    #assert_code_and_body(response, 404) #TODO: TV-4: Expected 404, actual 500 - bug outstanding.
  end

end