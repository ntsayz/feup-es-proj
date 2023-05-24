Feature: Create an event
  Scenario: Host can create an Event
    Given I am logged in
    When I tap the "createEvent" button
    Then I fill "eventNameField" with "name" and "eventDetailsField" with "details" and "eventLocationField" with "loation" and "eventDateField" with "date"
    And I tap "launchEvent" Button
    And I expect "teventScreen" to be present