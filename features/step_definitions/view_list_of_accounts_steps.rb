Given(/^there are accounts "(.*?)" and "(.*?)"$/) do |account1, account2|
  Account.create!(username: account1, password: 'password')
  Account.create!(username: account2, password: 'password')
end

When(/^I visit ooompa site$/) do
  visit '/'
end

Then(/^I should see "(.*?)" and "(.*?)"$/) do |account1, account2|
  page.should have_content(account1)
  page.should have_content(account2)
end

Then(/^I should be able to follow them$/) do
  pending # express the regexp above with the code you wish you had
end
