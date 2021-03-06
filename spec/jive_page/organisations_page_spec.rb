require 'spec_helper'
require 'json'
require 'json-schema'

describe 'Organisations end point' do

  it 'should return a 200 when requesting the organisations end point with id' do
    RestClient.get(ENV['base_url'] + '/api/core/v3/organisations/1',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 404 when requesting the organisations end point with a non-existing id' do
    RestClient.get(ENV['base_url'] + '/api/core/v3/organisations/-1',:cookie => @authorisation){|response|
      assert_code_and_body(response, 404)
    }
  end
 
  it 'should return a id, name, bio, size, type, telephone, email, name, website and avatar(logo) when requesting the organisations end point' do
    RestClient.get(ENV['base_url'] + '/api/core/v3/organisations/1',:cookie => @authorisation){|response|
      @data_hash = JSON.parse(response)
      #puts @data_hash

      fail('response does not have id') if (!@data_hash.has_key?('id'))
      fail('response does not have bio') if (!@data_hash.has_key?('bio'))
      fail('response does not have size') if (!@data_hash.has_key?('size'))
      fail('response does not have type') if (!@data_hash.has_key?('type'))
      fail('response does not have telephone') if (!@data_hash.has_key?('telephone'))
      fail('response does not have email') if (!@data_hash.has_key?('email'))
      fail('response does not have website') if (!@data_hash.has_key?('website'))
      fail('response does not have name') if (!@data_hash.has_key?('name'))
      fail('response does not have resources') if (!@data_hash.has_key?('resources'))
      fail('response does not have avatar') if (!@data_hash['resources'].has_key?('avatar'))
      
      #@ref_link = @data_hash['resources']['avatar']['ref']
      #puts @ref_link
      }
     end
    
   it 'should return a 200 when avatar/logo is requested' do
   		RestClient.get(ENV['base_url'] + '/api/core/v3/organisations/1',:cookie => @authorisation){|response|
     		 @data_hash = JSON.parse(response)
     		 @ref_link = @data_hash['resources']['avatar']['ref']
     	}
     		 
    		RestClient.get(@ref_link,:cookie => @authorisation){|response|
      			assert_code_and_body(response, 200)
    		}
  end   	

	it 'should return the response as per a valid schema' do
		RestClient.get(ENV['base_url'] + '/api/core/v3/organisations/1',:cookie => @authorisation){|response|
      file = File.read './lib/schemas/organisation_schema.json'
      sch = JSON.parse(file)

      begin
        JSON::Validator.validate!(sch, response)
      rescue JSON::Schema::ValidationError => e
        e.message
      end
		}
  end


end
