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
    Then the response status should be 200
  
  Scenario: Remember a user
    Given I signed up with user_name: "me", email: "me@example.com"
    When  I go to the sign in page
    And   I fill in "User name or email" with "me@example.com"
    And   I fill in "Password" with "big secret"
    And   I check "Remember me"
    And   I press "Sign In"
    Then  show me the cookies
    Then  the response status should be 200
    And   I close my browser
    Then  show me the cookies
    And   I go to the home page
    Then the response status should be 200

  Scenario: Sign in with facebook
