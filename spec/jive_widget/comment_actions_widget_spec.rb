require 'spec_helper'

describe 'Comment actions' do

  it 'should return a 200 when requesting all the comments for a piece of content' do
    RestClient.get(ENV['base_url'] + '/comment-list.jspa?location=jive-comments&mode=comments&isPrintPreview=false&object=4381&contentObjectType=11111&start=0&numResults=25&sort=datedesc&_=1435143878900',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end