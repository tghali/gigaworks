Feature: The home page
  In order to interact with the team
  every gigaworks user
  wants to check out his dashboard
  
  @announce
  Scenario: Open the home page
    When I go to "http://worx.example.com" # Dashboard page
    Given I am signed in
    Then the response status should be 200
    And the response header should have Content-Type set to "text/html; charset=utf-8"
    And I should see "Hello, person without javascript"
    Then show me the page

  @javascript
  Scenario: Open the home page with javascript
    Given I am signed in with user_name: "lpedroni"
    When I go to "http://worx.example.com"
    Then I should see "Welcome, person with javascript"