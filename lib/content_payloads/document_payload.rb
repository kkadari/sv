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
      :mobileEditor => false,
      :cancelURL => '/welcome',
      'jive.token.name' => 'jive.token.content.document.upload.2abd1459-28bf-4c59-a369-6706c71bb1ea',
      'jive.token.content.document.upload.2abd1459-28bf-4c59-a369-6706c71bb1ea' => '1500459677005-Q1E78QP4X01TLEHFHWQF7VGHVN3IJ0YS',
      :subject => @subject,
      :body => '<body><p>' + @body + '</p></body>',
      'publishBar.defaultAuthorshipPolicy' => '2',
      :draft => false,
      :jiveTokenName => 'jive.token.content.document.upload.2abd1459-28bf-4c59-a369-6706c71bb1ea',
      :handlingLevel => @handling_level,
      'publishBar.authorPolicy' => '2',
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
