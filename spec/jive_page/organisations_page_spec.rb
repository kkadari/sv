require 'spec_helper'
require 'json'
require 'json-schema'

describe 'Organisations end point' do

  it 'should return a 200 when requesting the organisations end point' do
    RestClient.get(ENV['base_url'] + '/api/core/v3/organisations/1',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a id, bio, size, type when requesting the organisations end point' do
    RestClient.get(ENV['base_url'] + '/api/core/v3/organisations/1',:cookie => @authorisation){|response|
      @data_hash = JSON.parse(response)

      fail('response does not have id') if (!@data_hash.has_key?('id'))
      fail('response does not have bio') if (!@data_hash.has_key?('bio'))
      fail('response does not have size') if (!@data_hash.has_key?('size'))
      fail('response does not have type') if (!@data_hash.has_key?('type'))
      fail('response does not have resources') if (!@data_hash.has_key?('resources'))
      }
     end

	it 'should return the response as per a valid schema' do
		RestClient.get(ENV['base_url'] + '/api/core/v3/organisations/1',:cookie => @authorisation){|response|
      file = File.read './lib/schemas/organisation_schema.json'
      sch = JSON.parse(file)

      begin
        puts(JSON::Validator.validate!(sch, response))
      rescue JSON::Schema::ValidationError => e
        e.message
      end
		}
  end


end
