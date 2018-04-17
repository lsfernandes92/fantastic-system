require 'rails_helper'

RSpec.describe TodoList, type: :model do
  LONG_STRING = (0...51).map { ('a'..'z').to_a[rand(26)] }.join

  before do
    @user = FactoryGirl.create(:user)
  end

  subject { FactoryGirl.create(:todo_list_public) }

  it 'should be valid' do
    expect(subject).to be_valid
  end

  it 'should be valid only with title' do
    subject.description = nil
    subject.public = false
    expect(subject).to be_valid
  end

  it 'should be invalid without title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'should be invalid with long titles(more than 50 characters)' do
    subject.title = LONG_STRING
    expect(subject).to_not be_valid
  end

  it 'should be invalid with long descriptions(more than 50 characters)' do
    subject.description = LONG_STRING
    expect(subject).to_not be_valid
  end

  describe "Associations" do
    it "should belongs to a user" do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it "should has many todo items" do
      assc = described_class.reflect_on_association(:todo_items)
      expect(assc.macro).to eq :has_many
    end
  end
end
