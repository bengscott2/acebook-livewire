require "rails_helper"
require 'pry'

RSpec.feature "Comment section is visible", type: :feature, js: true do
  scenario "click on comment within post and see the empty comment thread" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: "giraffe@email.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Submit"
    visit "/posts"
    click_link "New post"
    fill_in "Message", with: "Hello, giraffe!"
    click_button "Submit"
    click_link "Logout"
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: "tesymcemail@email.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Submit"
    find_link("Comment").click
    expect(page).to have_content "Hello, giraffe!"
    expect(page).to have_css '.comment-thread'
    expect(page).to have_link("Show Comments (0)", visible: false)
  end

  scenario "Two commenters post two comments" do
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: "opinionatedtroll@email.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Submit"
    visit "/posts"
    click_link "New post"
    fill_in "Message", with: "No!"
    click_button "Submit"
    click_link "Comment"
    find_link("Show Comments (0)", visible: false).click
    find_link("New Comment", visible: false).click
    find("textarea#comment_body", visible: false).set("I disagree.")
    find_button("Post Comment").click
    click_link "Logout"
    visit "/"
    click_link "Sign up"
    fill_in "Email", with: "tesymcemail@email.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Submit"
    find_link("Comment").click
    find_link("Show Comments (1)", visible: false).click
    find_link("New Comment", visible: false).click
    find("textarea#comment_body", visible: false).set("Hell no.")
    find_button("Post Comment").click
    expect(page).to have_content("I disagree.")
    expect(page).to have_content("Hell no.")
    expect(page).to have_css('.comment', text: "Hell no.")
    expect(page).to have_css('.comment_commontator', text: "tesymcemail@email.com")
    expect(page).to have_css('.comment_commontator', text: "opinionatedtroll@email.com")
  end

  xscenario "Editing a comment" 
 #   post_comment
 #   find_button("Edit").click
 #   find("textarea#comment_body", visible: false).set("Word.")
 #   expect(page).to have_css('.comment', text: "Word.")
 #   expect(page).not_to have_css('.comment', text: "I disagree.")
 # end

  xscenario "Deleting a comment"
end
