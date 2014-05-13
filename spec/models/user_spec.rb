require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  before { @user = User.new(name: "Example User", email: "user@example.com",
                            password: "user123", password_confirmation: "user123") }
  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:awkiposts)}
  it { should respond_to(:feed) }

  it { should be_valid }
  it { should_not be_admin }


  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
  
  describe "when name is not present" do
  	before { @user.name = " " }
  	it { should_not be_valid }
  end

  describe "when email is not present" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end
  
  describe "when passwords do not match" do
    before { @user.password_confirmation = "user321" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe "with admin attribute set to 'true' " do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "awkipost associations" do

    before { @user.save }
    let!(:older_awkipost) do
      FactoryGirl.create(:awkipost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_awkipost) do
      FactoryGirl.create(:awkipost, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right awkiposts in the right order" do
      expect(@user.awkiposts.to_a).to eq [newer_awkipost, older_awkipost]   
    end

    it "should destroy associated awkiposts" do
      awkiposts = @user.awkiposts.to_a
      @user.destroy
      expect(awkiposts).not_to be_empty
      awkiposts.each do |awkipost|
        expect(Awkipost.where(id: awkipost.id)).to be_empty
      end
    end

    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:awkipost, user: FactoryGirl.create(:user))
      end

      its(:feed) { should include(newer_awkipost) }
      its(:feed) { should include(older_awkipost) }
      its(:feed) { should_not include(unfollowed_post) }
    end

  end
end
