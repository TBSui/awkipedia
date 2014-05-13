require 'spec_helper'

describe Awkipost do

  let(:user) { FactoryGirl.create(:user) }
  before { @awkipost = user.awkiposts.build(content: "This is Awkward")}

  subject { @awkipost}

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @awkipost.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @awkipost.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @awkipost.content = "a" * 501 }
    it { should_not be_valid }
  end
end
