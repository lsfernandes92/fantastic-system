require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryGirl.create(:default_user) }

  before do
    @user = FactoryGirl.create(:user)
  end

  describe "Sign up validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with invalid an email" do
      subject.email = "teste"
      expect(subject).to_not be_valid
    end

    it "is not valid with a short password(6 characters minimum)" do
      subject.password = "short"
      expect(subject).to_not be_valid
    end

    it "is not valid with email that has already been taken" do
      subject.email = @user.email
      expect(subject).to_not be_valid
    end
  end

  describe "Associations" do
    it "should has many todo lists" do
      assc = described_class.reflect_on_association(:todo_lists)
      expect(assc.macro).to eq :has_many
    end

    it "should has many favorites" do
      assc = described_class.reflect_on_association(:favorites)
      expect(assc.macro).to eq :has_many
    end

    it "should has many favorite_todo_lists" do
      assc = described_class.reflect_on_association(:favorite_todo_lists)
      expect(assc.macro).to eq :has_many
    end

    it "should has many notifications" do
      assc = described_class.reflect_on_association(:notifications)
      expect(assc.macro).to eq :has_many
    end
  end
end
