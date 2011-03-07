Feature: Creating Users
  In order to have clients and employees use the platform
  as an admin
  wants to invite users and add departements

Scenario: Creating an account for an employee
  Given an admin exists
  Given I am signed in as admin
  Given a user contact: "john" exists with first_name: "John"
  When I go to "http://worx.example.com/glossary"
  When I go to the contact page for the user contact: "john"
  When I follow "Create user account"
  Then show me the page

Scenario: Issuing an invite to a client
  # Given context
  # When event
  # Then outcome


