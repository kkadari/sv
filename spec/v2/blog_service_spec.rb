require 'spec_helper'

describe 'blog_service_v2' do

  describe 'GET Blogs' do
    it 'should return 200 on request of blogs' do
      RestClient.get('http://dev188.sure.vine/api/core/v2/blogs?limit=100',{:Authorization => @authorisation}){ |response, request, result, &block|
        fail('Failed with ' + response.code) if response.code != 200
      }
    end

    it 'should return 200 on request of a specific blog' do
      RestClient.get('http://dev188.sure.vine/api/core/v2/blogs/1005',{:Authorization => @authorisation}){ |response, request, result, &block|
        fail('Failed with ' + response.code) if response.code != 200
      }
    end
  end

end