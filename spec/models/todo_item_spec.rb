require 'rails_helper'

RSpec.describe TodoItem, type: :model do
  LONG_STRING = (0...41).map { ('a'..'z').to_a[rand(26)] }.join

  subject { FactoryGirl.create(:default_todo_item) }

  it 'should be valid' do
    expect(subject).to be_valid
  end

  it 'should be invalid without content' do
    subject.content = nil
    expect(subject).to_not be_valid
  end

  it 'should be invalid with long content(more than 40 characters)' do
    subject.content = LONG_STRING
    expect(subject).to_not be_valid
  end

  describe "Associations" do
    it "should belongs to a todo list" do
      assc = described_class.reflect_on_association(:todo_list)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
