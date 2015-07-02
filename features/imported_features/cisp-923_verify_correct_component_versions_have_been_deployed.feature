Feature: [CISP-923] Verify correct component versions have been deployed
#<p>As part of the SIT, the web-overlay and plugin versions should be checked to ensure they match the expected versions for the release.</p>

  Scenario: Verify correct component versions have been deployed
	Given I obtain the component version numbers from the relevant CE release
	  | [Check the pom.xml file within GitLab for the tagged version of the cert-ce project] |
	Then I know which CE component version numbers should be deployed as part of the relevant CE release
	And I check the version of the web-overlay that has been deployed
	  | [Check web-overlay version deployed to jive/sbs folder.] |
	Then the web-overlay version deployed matches the expected version for the CE release
	And I login to the CE Admin Console
	  | [As an Admin User] |
	And I check the correct Jive SBS Version is displayed
	  | [Displayed in top right of Admin Console] |
	Then the correct Jive SBS version is applied
	And I navigate to System -> Plugins
	Then I am viewing the list of plugins currently installed on the CE
	And if I check the version of the plugins that have been installed
	Then the plugin versions match the expected versions for the CE release
