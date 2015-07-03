Feature: [CISP-173] Participant wants to spellcheck using the British (United Kingdom) dictionary
#<p>By default, the CE should be configured to use the British (United Kingdom) dictionary when conducting a spellcheck within the TinyMCE editor. </p>
#<p>If it is not (or if this test fails), ensure the following System Property has been applied (it may need creating); it sets the default spell check language to en_gb. Note: This will require Jive to be restarted after applying the configuration change. </p>
#<p>key : spelling.dictionaries <br/>
#value : sscebr.tlx,sscebr2.clx,accentbr.tlx,correctbr.tlx </p>

  Scenario: Participant wants to spellcheck using the British (United Kingdom) dictionary
	Given I log in
		| CE participant email and password |
	And I create a new discussion
	  """  Subject:
	  Is the British (UK) dictionary enabled for spellcheck by default?

	  Body:
	  {Import the attached 'USvsUK-Content.txt' file into the TinyMCE HTML Editor}  """
	When I switch to Full Editor and enable spellcheck
	Then the TinyMCE editor is reverted from HTML Editor to Full Editor and spellcheck is enabled
	And the default dictionary is used
	Then the default dictionary is "English (United Kingdom)"
