require 'spec_helper'
require 'rails_helper'

feature 'Edit todo list' do
  before do
    @user = FactoryGirl.create(:user)
  end

  scenario 'marking as private' do
    FactoryGirl.create(:todo_list_public, user: @user)
    log_in_with @user.email, @user.password
    click_link 'New todo list public'

    expect(page).to have_content('Mark as private')
  end

  scenario 'marking as public' do
    FactoryGirl.create(:todo_list_private, user: @user)
    log_in_with @user.email, @user.password
    click_link 'New todo list private'

    expect(page).to have_content('Mark as public')
  end

  private

    def log_in_with(email, password)
      visit new_user_session_path
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      click_button 'Log in'
    end
end
