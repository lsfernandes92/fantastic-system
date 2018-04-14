require 'spec_helper'
require 'rails_helper'

feature 'Show public lists' do
  before do
    @user = FactoryGirl.create(:user)
  end

  scenario 'from other users' do
    FactoryGirl.create(:todo_list_public)
    log_in_with @user.email, @user.password
    click_link 'New todo list public'

    expect(page).to have_content('Mark as favorite')
  end

  private

    def log_in_with(email, password)
      visit new_user_session_path
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      click_button 'Log in'
    end
end
