class DocumentPayload < Payload

  def initialize(subject, body, handling_level, upload_file)
    @subject = subject
    @body = body
    @handling_level = set_ihm_level(handling_level)
    @upload_file = File.new(File.dirname(__FILE__) + '/../../bin/' + upload_file)
  end

  def payload
    {
        :subject => @subject,
        :body => '<body><p>' + @body + '</p></body>',
        :handlingLevel => @handling_level,
        'publishBar.visibility' => 'all',
        'publishBar.defaultAuthorshipPolicy' => '2',
        'publishBar.commentStatus' => '2',
        :uploadFile => @upload_file,
        :multipart  => true
    }
  end

end