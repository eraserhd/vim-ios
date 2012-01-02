Feature: Adding and removing
  In order to keep working in Vim,
  as a Vim hacker,
  I'd like to use :Xadd and :Xremove to update the Xcode project.

  @wip
  Scenario: Xadd
    Given my Xcode project has the following targets:
      | Foo |
      | Bar |
      | Baz |
    And my Xcode project has the following groups:
      | Classes |
    And I have a file "foo.cpp"
    When I run ":Xadd Classes Foo,Baz" in Vim
    Then "Classes/foo.cpp" will exists in Xcode project
    And "Classes/foo.cpp" will refer to "foo.cpp"
    And "Classes/foo.cpp" will be in target "Foo"
    And "Classes/foo.cpp" will be in target "Bar"
    And "Classes/foo.cpp" will not be in target "Baz"
