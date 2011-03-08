Feature: Creating Users
  In order to have clients and employees use the platform
  as an admin
  wants to invite users and add departements

Scenario: Creating an account for an employee
  Given an admin exists
  Given I am signed in as admin
  Given a user contact: "john" exists with first_name: "John", email: "john@example.com"
  When I go to "http://worx.example.com/glossary"
  When I go to the contact page for the user contact: "john"
  When I follow "Invite user to gigaworx"
  Then 1 email should be delivered to "john@example.com"
  When I go to "http://worx.example.com/sign_out"
  Given  I click the first link in the email
  When I fill in "User name" with "john"
  And  I fill in "Password" with "big secret"
  And  I fill in "Password confirmation" with "big secret"
  And  I check "user_terms_of_service"
  And  I check "user_privacy_policy"
  And  I press "Sign Up"
  Then I should see "Congratulations, you succesfully registered"
  Then a user should exist with user_name: "john"
  And the user should be verified
  # Logging in with the new account
  When I fill in "User name" with "john"
  And  I fill in "Password" with "big secret"
  And I press "Sign In"
  Then show me the page
  Then the response status should be 200

Scenario: Issuing an invite to a client
  # Given context
  # When event
  # Then outcome


