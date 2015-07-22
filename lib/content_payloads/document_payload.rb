class DocumentPayload < Payload

  def initialize(subject, body, handling_level, upload_file, visibility={:location => 'all'})
    @subject        = subject
    @body           = body
    @handling_level = set_ihm_level(handling_level)
    @upload_file    = File.new(File.dirname(__FILE__) + '/../../bin/' + upload_file)
    @visibility     = visibility
  end

  def payload
    payload = {
        :subject => @subject,
        :body => '<body><p>' + @body + '</p></body>',
        :handlingLevel => @handling_level,
        'publishBar.defaultAuthorshipPolicy' => '2',
        'publishBar.commentStatus' => '2',
        :uploadFile => @upload_file,
        :multipart  => true
    }

    case @visibility[:location]
      when 'all'
        payload['publishBar.visibility'] = 'all'
      when 'place'
        payload['publishBar.visibility'] = 'place'
        payload['publishBar.container.objectType'] = 700
        payload['publishBar.container.objectID'] = 1005
      else
        fail('An error occurred when setting the visibility for a document')
    end

    payload
  end

end