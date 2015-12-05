require 'spec_helper'
describe SessionsController, type: :controller do
  context "new" do
    it "is successful" do
      get :new
      expect(response).to be_success
    end
  end

  context "#create" do
    let(:user) { FactoryGirl.create :user }
    it "redirects to root path if correct credentials" do
      post :create, :email => user.email, :password => user.password
      expect(response).to redirect_to root_path
    end
    it "renders new template with bad email" do
      post :create, :email => "wrong@email.com", :password => user.password
      expect(response).to render_template(:new)
    end
    it "renders new template with bad password" do
      post :create, :email => user.email, :password => "wrong password"
      expect(response).to render_template(:new)
    end
  end

  context "#destroy" do
    let(:user) { FactoryGirl.create :user }
    it "redirects to root path when a user logs out" do
      post :create, email: user.email, password: user.password
      delete :destroy
      expect(response).to redirect_to root_path
    end
  end
end
