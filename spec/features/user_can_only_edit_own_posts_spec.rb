require 'rails_helper'
require 'sign_up_helper'
require 'post_hi_earth_helper'
require 'date'

RSpec.feature "Edit posts", type: :feature do

  scenario "User can edit post" do
    sign_up
    post_hi_earth
    find_button("Edit").click

    expect(page).to have_content("Hi, earth!")

    fill_in "post[message]", with: "Goodbye, planet!"
    click_button "Submit"

    expect(page).to have_current_path('/posts')
    expect(page).not_to have_content("Hi, earth!")
    expect(page).to have_content("Goodbye, planet!")
  end

  feature "Editing restrictions" do

    scenario "Edit button only appears on user's own posts" do
      sign_up
      visit "/posts"
      click_link "New post"
      fill_in "Message", with: "Hello, world!"
      click_button "Submit"
      click_link "Logout"
      sign_up_different_user
      post_hi_earth

      first_post = page.find('div.post', text: 'Hello, world')
      second_post = page.find('div.post', text: 'Hi, earth')

      expect(first_post).not_to have_button('Edit')
      expect(second_post).to have_button('Edit')
    end

    scenario "User cannot edit other users' posts" do
      sign_up
      post_hi_earth
      click_button "Edit"
      url = URI.parse(current_url).to_s[22..-1]
      click_link "Logout"
      sign_up_different_user
      visit url

      expect(page).to have_current_path("/posts")
      expect(page).to have_content("Unable to edit another user's posts")
    end

    scenario "User can't edit posts after 10 minutes" do
      time_11_mins = DateTime.now + (11.0 / (24 * 60))
      allow(DateTime).to receive(:now).and_return(time_11_mins)

      sign_up
      post_hi_earth

      first_post = page.find('div.post', text: 'Hi, earth!')
      expect(first_post).not_to have_button('Edit')
    end

    scenario "User cannot edit own posts after 10 minutes" do
      sign_up
      post_hi_earth
      click_button "Edit"
      url = URI.parse(current_url).to_s[22..-1]

      time_11_mins = DateTime.now + (11.0 / (24 * 60))
      allow(DateTime).to receive(:now).and_return(time_11_mins)

      visit "/posts"
      visit url

      expect(page).to have_current_path("/posts")
      expect(page).to have_content("Unable to edit post after 10 minutes")
    end
  end

end
