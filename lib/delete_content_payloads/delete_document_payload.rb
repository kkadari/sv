class DeleteDocumentPayload

  def initialize(doc_id, token)
    @doc_id = doc_id
    @token  = token
  end

  def payload
    'jive.token.name=document.delete.' + @doc_id + '&document.delete.' + @doc_id + '=' + @token
  end

end