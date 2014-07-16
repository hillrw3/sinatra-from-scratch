require "spec_helper"

describe 'homepage' do
  it "lets user sign up"
  visit "/"
  click_on "Register"
  expect(page).to have_content("Email")
end