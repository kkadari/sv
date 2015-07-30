class DeleteIncidentReportPayload

  def initialize(doc_id, token)
    @doc_id = doc_id
    @token  = token
  end

  def payload
    'jive.token.name=incidentReport.delete.' + @doc_id + '&incidentReport.delete.' + @doc_id + '=' + @token + '&incidentReportID=' + @doc_id + '&delete=Delete'
  end

end