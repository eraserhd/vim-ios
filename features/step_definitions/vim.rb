
Given /^I am editing "([^"]*)"$/ do |name|
  set_current_buffer_name(name)
end

When /^I run "([^"]*)" in Vim$/ do |command|
  run_vim_command(command)
end

