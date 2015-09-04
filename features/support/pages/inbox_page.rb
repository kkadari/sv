class InboxPage
  include PageObject
  extend UrlFactory

  page_url(inboxpage)

  div(:notifications, :css => '.j-act-notifications')
  div(:inbox_message, :css => '.j-aq-entry')
  a(:confirm_notification, :css => '.j-action-button')
  a(:open_filter, :css => '#communications-filter-trigger')
  a(:filter_by_notificiation, :css => '.j-act-filter-options > li:nth-child(4) > a')

end
