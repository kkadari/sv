class GroupPayload < Payload

  def initialize(group_name, type)
    @group_name = group_name
    @type       = type
  end

  def payload
    '{
        "enabledContentTypes":"incidentReports",
        "socialGroup":"1065",
        "placeTypeName":"group",
        "name":"' + @group_name + '",
        "description":"Created during auto test - can be deleted",
        "tags":[],
        "groupType":"' + @type + '",
        "placeTabVisibility.selection":"activity",
        "placeTabVisibility.landing":"activity",
        "type":"group",
        "contentTypes":["blog","documents","discussions","polls","extStreamActivities","incidentReports"],
        "visibleToExternalContributors":false,
        "displayName":"' + @group_name + '",
        "headerSettings":{
          "bgColor":"cccccc",
          "textColor":"ffffff",
          "bgType":"preset",
          "bgPosition":"left top",
          "bgPresetImageUrl":"/images/placeBackgrounds/bokeh1.png",
          "bgRepeat":"repeat"
        }
    }'
  end

end
