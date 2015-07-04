Feature: Delete a place

  Scenario: Participant deletes a secret group
    Given I have created a secret group with content
    When I opt to delete the secret group
    Then the Secret Group is deleted
    And all content created within that group no longer exists within the system