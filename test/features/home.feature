Feature: Testing Home Page content
As an user, I want to be able to test
the home page text

  Scenario: Home Page Title
    Given I am on "/"
    Then I should see "home"
    Then I should see "homes"
