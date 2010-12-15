Feature: Signing in
  In order to engage with advanced features
  a client or employee with
  wants to sign in
  
  Scenario: Signing in with an email bound account
    Given I signed up with user_name: "me", email: "me@example.com"
    When  I go to the sign in page
    And   I fill in "User name or email" with "me@example.com"
    And   I fill in "Password" with "big secret"
    And   I press "Sign In"
    Then show me the page
    Then the response status should be 200

  Scenario: Remember a user

  Scenario: Sign in with facebook
