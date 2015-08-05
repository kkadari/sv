class RequestANewGroup
  include PageObject

  in_iframe(:id => '__gadget_j-app-modal-parent') do |frame|
    text_field(:group_name, :css => '#group-name-input', :frame => frame)
    text_area(:group_desc, :name => 'description', :frame => frame)
    button(:additional_owner, :id => 'second_btn_owner_picker', :frame => frame)
    button(:supported, :id => 'btn_supporters_picker', :frame => frame)
    button(:request, :id => 'requestNewGroup', :frame => frame)
    div(:alert, :css => '.alert', :frame => frame)
  end

end
