class EditDocumentPayload < Payload

  def initialize(doc_id, subject, upload_file)
    @doc_id = doc_id
    @subject = subject
    @upload_file = upload_file
  end

  def payload
    {
      :mobileEditor => false,
      :cancelURL => '/docs/DOC-' + @doc_id,
      'jive.token.name' => 'jive.token.content.document.editUpload',
      'jive.token.content.document.editUpload.69e9e414-c795-4c37-9249-f9191f76e014' => '1500460178179-11YSY0ZRN5SCH1CD5XIP4QRGH1ZYKF4Y',
      :documentID => @doc_id.gsub('DOC-',''),
      :subject => @subject,
      :body => '<body><p>body content here</p></body>',
      :handlingLevel => 1,
      'publishBar.visibility' => 'all',
      'publishBar.defaultAuthorshipPolicy' => 2,
      'publishBar.commentStatus' => 2,
      :draft => false,
      :editedVersion => 1,
      :jiveTokenName => 'jive.token.content.document.editUpload',
      :uploadFile => File.new(File.dirname(__FILE__) + '/../../bin/' + @upload_file),
      :multipart  => true
    }
  end

end
