require 'spec_helper'

describe 'Vote comment widget' do

  it 'should return a 200 when liking a comment' do

    # Create a blog post
    attack = %w(DDoS phishing logic-bomb trojan).sample
    system = Faker::Company.catch_phrase.downcase
    subject = "My thoughts on #{system} #{attack} attacks"
    body = Faker::Lorem.paragraph(50,false,50)

    payload = V3BlogPayload.new(subject,body,'amber','test1, test2, test3').payload

    RestClient.post(ENV['base_url'] + '/api/core/v3/contents/',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      assert_code_and_body(response, 201)
      @blog_id = JSON.parse(response)['id']
    }

    # Comment on the blog post
    payload = CommentPayload.new('Comment here', true).payload
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/comments/38/' + @blog_id, payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
      @@comment_id = JSON.parse(response)['commentID'].to_s
    }

    # Switch user
    @authorisation2 = Login.do_login(ENV['username_2'],ENV['password_2'])

    # Like the comment
    payload = 'ratingType=like&voteValue=1'
    RestClient.post(ENV['base_url'] + '/__services/v2/rest/acclaim/105/' + @@comment_id + '/addvote',payload,:cookie => @authorisation2){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when unliking a comment' do
    payload = 'ratingType=like'

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/acclaim/105/' + @@comment_id + '/removevote',payload,:cookie => @authorisation2){|response|
      assert_code_and_body(response, 200)
      puts response
    }
  end

end
