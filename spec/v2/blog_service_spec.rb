require 'spec_helper'

describe 'blog_service_v2' do

    it 'should return a 200 on create a blog' do
      payload = 'subject=' + Faker::Company.catch_phrase + '&html=%3Cdiv+class%3D%22jive-rendered-content%22%3EFoobar%3C%2Fdiv%3E'

      RestClient.post('http://dev188.sure.vine/api/core/v2/blogs/1005/posts',payload,:Authorization => @authorisation) { |response|
        fail('Failed with ' + response.code.to_s) if response.code != 201
      }
    end

    it 'should return 201 on following a blog' do
      RestClient.post('http://dev188.sure.vine/api/core/v2/blogs/1005/followers', '{id: 1005}', :Authorization => @authorisation) { |response|
        fail('Failed with ' + response.code.to_s) if response.code != 201
      }
    end

    it 'should return 200 on confirming a follower for a blog' do
      RestClient.get('http://dev188.sure.vine/api/core/v2/blogs/1005/followers/' + ENV['user_id'], :Authorization => @authorisation) { |response|
        fail('Failed with ' + response.code.to_s) if response.code != 200
      }
    end

    it 'should return 204 on unfollowing a blog' do
      RestClient.delete('http://dev188.sure.vine/api/core/v2/blogs/1005/followers/' + ENV['user_id'], :Authorization => @authorisation) { |response, request|
        fail('Failed with ' + response.code.to_s) if response.code != 204
      }
    end

    it 'should return 200 on request of blogs' do
      RestClient.get('http://dev188.sure.vine/api/core/v2/blogs?limit=100', :Authorization => @authorisation){ |response|
        fail('Failed with ' + response.code.to_s) if response.code != 200
      }
    end

    it 'should return 200 on request of a specific blog' do
      RestClient.get('http://dev188.sure.vine/api/core/v2/blogs/1005', :Authorization => @authorisation){ |response|
        fail('Failed with ' + response.code.to_s) if response.code != 200
      }
    end

    it 'should return 200 on request of a blogs posts' do
      RestClient.get('http://dev188.sure.vine/api/core/v2/blogs/1005/posts?limit=100', :Authorization => @authorisation){ |response|
        fail('Failed with ' + response.code.to_s) if response.code != 200
      }
    end

end