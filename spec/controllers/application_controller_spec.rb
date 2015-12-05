require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let!(:user) {FactoryGirl.create(:user)}

  describe "#logged_in?" do
    context "with a logged in user" do

      before do
        session[:user_id] = user.id
      end

      it "returns true" do
        expect(controller.send(:logged_in?)).to eq true
      end
    end

    context "with no user logged in" do
      it "returns false" do
        expect(controller.send(:logged_in?)).to eq false
      end
    end
  end

  describe "#current_user" do
    context "with a logged in user" do

      before do
        session[:user_id] = user.id
      end

      it "returns the user that is logged in" do
        expect(controller.send(:current_user)).to eq user
      end
    end

    context "with no user logged in" do
      it "returns nil" do
        expect(controller.send(:current_user)).to eq nil
      end
    end
  end


end
