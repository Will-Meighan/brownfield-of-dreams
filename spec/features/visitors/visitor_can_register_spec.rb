require 'rails_helper'

describe 'visitor can create an account', :js do
  it ' visits the home page' do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    expect do
      click_on "Create Account"
    end.
    to change { ActionMailer::Base.deliveries.count }.by(1)

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content(email)
    expect(page).to have_content(first_name)
    expect(page).to have_content(last_name)
    expect(page).to_not have_content('Sign In')
    expect(page).to have_content("Logged in as #{first_name}.")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")
    expect(page).to have_content("Status: Inactive")

    user = User.last

    visit "/activate/#{user.id}"

    expect(current_path).to eq(dashboard_path)
    expect(page).to_not have_content("Status: Inactive")
  end

  it 'cannot sign up with existing email' do
    user1 = create(:user, email: 'jimbob@aol.com')

    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/users/new'

    fill_in "user[email]", with: "jimbob@aol.com"
    fill_in "First name", with: "Jim"
    fill_in 'user[last_name]', with: 'last_name'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'

    click_on 'Create Account'

    expect(page).to have_content('Username already exists')
  end
end
