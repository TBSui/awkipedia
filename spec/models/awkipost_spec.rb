require 'spec_helper'

describe Awkipost do

  let(:user) { FactoryGirl.create(:user) }
  before do
    # This code is not idiomatically correct.
    @awkipost = Awkipost.new(content: "This is awkward", user_id: user.id)
  end

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
end
