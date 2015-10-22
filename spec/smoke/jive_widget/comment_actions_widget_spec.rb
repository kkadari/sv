require 'spec_helper'

describe 'Comment actions' do

  it 'should return a 200 when requesting all the comments for a piece of content' do
    RestClient.get(ENV['base_url'] + '/comment-list.jspa?location=jive-comments&mode=comments&isPrintPreview=false&object=1790&contentObjectType=18&start=0&numResults=25&sort=datedesc&_=1435235022290',{:cookie => @authorisation, 'X-Requested-With' =>'XMLHttpRequest'}){|response|
      assert_code_and_body(response, 200)
    }
  end

end
