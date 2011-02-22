Feature: Adding Contacts
  In order to register a contact inside the address book
  as an admin or sales person
  wants add contacts


  Scenario: Create a new contace
    When I go to "http://worx.example.com" # Dashboard page
    Given an admin is signed in
    Given an client exists with name: "Acme"
    When I follow "Contacts"
