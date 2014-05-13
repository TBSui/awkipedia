require 'spec_helper'

describe "AwkipostPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "awkipost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a awkipost" do
        expect { click_button "Post" }.not_to change(Awkipost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'awkipost_content', with: "Lorem ipsum" }
      it "should create a awkipost" do
        expect { click_button "Post" }.to change(Awkipost, :count).by(1)
      end
    end
  end

  describe "awkipost destruction" do
    before { FactoryGirl.create(:awkipost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a awkipost" do
        expect { click_link "delete" }.to change(Awkipost, :count).by(-1)
      end
    end
  end
end
