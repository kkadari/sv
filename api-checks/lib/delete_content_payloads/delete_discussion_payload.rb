class DeleteDiscussionPayload

  def initialize(thread, message, token)
    @thread  = thread
    @message = message
    @token   = token
  end

  def payload
    'jive.token.name=thread.delete.' + @thread + '&thread.delete.' + @thread + '=' + @token + '&start=0&tstart=0&thread=' + @thread + '&message=' + @message + '&delete=Delete'
  end

end
