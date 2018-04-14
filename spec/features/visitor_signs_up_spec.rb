require 'spec_helper'
require 'rails_helper'

feature 'Visitor signs up' do
  scenario 'with valid email and password' do
    sign_up_with 'valid@example.com', 'password'

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  context "with invalid fields" do
    scenario 'invalid email' do
      sign_up_with 'invalid_email', 'password'

      expect(current_path).to eq('/users')
      expect(page).to have_content('Sign up')
    end

    scenario 'password less than 6 characters' do
      sign_up_with 'valid@example.com', 'pass'

      expect(current_path).to eq('/users')
      expect(page).to have_content('Password is too short (minimum is 6 characters)')
    end

    scenario 'blank email and password' do
      sign_up_with '', ''

      expect(current_path).to eq('/users')
      expect(page).to have_content('Password can\'t be blank')
      expect(page).to have_content('Email can\'t be blank')
    end
  end

  private

    def sign_up_with(email, password)
      visit new_user_registration_path
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password
      click_button 'Sign up'
    end
end
