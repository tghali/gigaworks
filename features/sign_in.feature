Feature: Signing in
  In order to engage with advanced features
  a client or employee with
  wants to sign in
  
  Scenario: Signing in with an email bound account
    Given I signed up with user_name: "me", email: "me@example.com"
    When  I go to "http://worx.example.com"
    When  I go to the sign in page
    And   I fill in "User name or email" with "me@example.com"
    And   I fill in "Password" with "big secret"
    And   I press "Sign In"
    Then  the response status should be 200
    
  Scenario: Signing in with an email bound account
    Given I signed up with user_name: "me", email: "me@example.com"
    When  I go to "http://worx.example.com"
    And   I fill in "User name or email" with "me@example.com"
    And   I fill in "Password" with "big secret"
    And   I press "Sign In"
    Then  show me the cookies
    Then  the response status should be 200

  
  Scenario: Remember me remembers across browsing sessions
    Given I signed up with user_name: "me", email: "me@example.com"
    When  I go to the sign in page
    And   I fill in "User name or email" with "me@example.com"
    And   I fill in "Password" with "big secret"
    And   I check "Remember me"
    And   I press "Sign In"
    Then  the response status should be 200
    And   I close my browser
    When  I go to "http://worx.example.com"
    Then  show me the cookies
    Then  the response status should be 200
  
  Scenario: Expire session after an hour
    Given I signed up with user_name: "me", email: "me@example.com"
    When  I go to "http://worx.example.com/sign_in"
    And   I fill in "User name or email" with "me@example.com"
    And   I fill in "Password" with "big secret"
    And   I press "Sign In"
    Then  the response status should be 200
    When  90 minutes have passed
    When  I go to "http://worx.example.com"
    Then the response status should be 401
  
  Scenario: Refresh session before the hour is past
    Given I signed up with user_name: "me", email: "me@example.com"
    When  I go to "http://worx.example.com/sign_in"
    And   I fill in "User name or email" with "me@example.com"
    And   I fill in "Password" with "big secret"
    And   I press "Sign In"
    Then  the response status should be 200
    # When  10 minutes have passed
    # Then  show me the cookies
    When  I go to "http://worx.example.com"
    Then  the response status should be 200
    And   show me the cookies
    When  40 minutes have passed
    And   I go to "http://worx.example.com"
    Then  the response status should be 200
  
  Scenario: Wrong password
    Given I signed up with user_name: "me", email: "me@example.com"
    When  I go to the sign in page
    And   I fill in "User name or email" with "me@example.com"
    And   I fill in "Password" with "wrong password"
    And   I press "Sign In"
    Then  the response status should be 401
    And I should see "Wrong user name or password"
    
  Scenario: Not signing in
    When  I go to "http://worx.example.com"
    Then  the response status should be 401
    And   I should see "You have to sign in with the credentials provided by Gigavine to use this application."
  
  # Scenario: Sign in with facebook
  #   Given a facebook account with email: "me@example.com" is authorized
  #   When  I go to "auth/facebook"