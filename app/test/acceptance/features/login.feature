Feature: User Login
  As a user,
  I want to be able to log in to my account
  So I can access my personal information and features

  Background:
    Given I am on the login page

  Scenario: Successful Login
    Given I enter my email "test@gmail.com"
    And I enter my password "password123"
    When I tap on the login button
    Then I should be redirected to the main screen
    And I should see my user ID "testID"

  Scenario: Unsuccessful Login
    Given I enter my email "wrongemail@gmail.com"
    And I enter my password "password123"
    When I tap on the login button
    Then I should see the error message "ENTER A VALID COMBINATION"
