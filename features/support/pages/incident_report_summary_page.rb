class IncidentReportSummaryPage
  include PageObject
  extend UrlFactory

  page_url(incidentreportsummarypage)

  link(:edit_ir_button, :text => 'Edit')
  image(:avatar, :class => 'jive-avatar anonymous-avatar')
  div(:first_comment, :class => 'jive-comment-container')
  h1(:title, :css => '.jive-incidentreport h1')

  link(:delete, :text => 'Delete')
  div(:delete_confirm, :id => 'jive-modal-incidentreport-delete')
  button(:confirm_delete, :id => 'deletebutton')

  div(:ihm_bar, :class => 'ihmbar')
  link(:export_to_pdf, :text => 'View as PDF')

end
