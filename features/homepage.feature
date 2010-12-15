Feature: The home page
  In order to interact with the team
  every gigaworks user
  wants to check out his dashboard
  
  Scenario: Open the home page
    Given I am signed in
    When I go to the home page
    Then the response status should be 200
    And the response header should have Content-Type set to "text/html; charset=utf-8"
    And I should see "Welcome"

  @javascript
  Scenario: Open the home page with javascript
    Given I am signed in with user_name: "lpedroni"
    When I go to the home page
    Then I should see "Welcome, person with javascript"
