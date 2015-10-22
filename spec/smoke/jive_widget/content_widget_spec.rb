require 'spec_helper'

describe 'Content widget' do

  it 'should return a 200 when requesting one of the filtered views of content' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/content?filterGroupID=content&token=MTQzNDcxOTE1MTE3MnwyMHxbQkAxMWIzNjQxOQ%3D%3D&itemViewID=detail&start=0&numResults=20&filterID=historyarchetype%5Bcontent%5D&itemView=detail&userID=' + @id + '',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

end
