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

      file = File.read './lib/schemas/organisation_schema.json'
      sch = JSON.parse(file)

      data = JSON.parse(response)
      puts(response)
      puts(file.to_s)
      #schema1 = JSON.load('../../lib/schemas/organisation_schema.json')

      fail('schema is valid') if(!(JSON::Validator.validate(sch, data)))
      #
      #
      schema = {
          "type" => "object",
          "required" => ["a"],
          "properties" => {
              "a" => {"type" => "integer"}
          }
      }

      #
      # validate ruby objects against a ruby schema
      #

      # => true
      puts(JSON::Validator.validate(schema, { "a" => 5 }))

      begin
        puts(JSON::Validator.validate!(sch, response))
      rescue JSON::Schema::ValidationError => e
        e.message
      end

      puts @data_hash.keys
    }


  end


end
