require 'spec_helper'
require 'rails_helper'

feature 'Create todo list' do
  background do
    @user = FactoryGirl.create(:user)
  end

  scenario 'marked as public' do
    log_in_with @user.email, @user.password
    create_new_todo_list_with 'New todo list', 'Some description', true
    click_link 'New todo list'

    expect(page).to have_content('Mark as private')
  end

  scenario 'marked as private' do
    log_in_with @user.email, @user.password
    create_new_todo_list_with 'Another todo list', 'Another description', false
    click_link 'Another todo list'

    expect(page).to have_content('Mark as public')
  end

  private

    def create_new_todo_list_with(title, description, public)
      click_link 'New Todo List'
      fill_in 'todo_list_title', with: title
      fill_in 'todo_list_description', with: description
      check('todo_list_public') if public
      click_button 'Create Todo list'
    end

    def log_in_with(email, password)
      visit new_user_session_path
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
      click_button 'Log in'
    end
end
