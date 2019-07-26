def sign_up
  visit "/"
  click_link "Sign up"
  fill_in "Email", with: "tesymcemail@email.com"
  fill_in "Password", with: "password"
  fill_in "Password confirmation", with: "password"
  click_button "Submit"
end

def sign_up_different_user
  click_link "Sign up"
  fill_in "Email", with: "differentemail@email.com"
  fill_in "Password", with: "password"
  fill_in "Password confirmation", with: "password"
  click_button "Submit"
end
