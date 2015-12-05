require 'spec_helper'

feature 'User browsing the website' do
	before :each do
		user = FactoryGirl.create(:user)
		visit login_path
		fill_in "password", with: user.password
		fill_in "email", with: user.email
		click_button "Log in"
		stub_authorize_user!
		5.times{FactoryGirl.create(:question)}
	end

	context "on hompage" do
		it "sees a list of recent question titles" do
      visit root_path
      expect(page).to have_css('li')
    end

    it "sees a Logout button when logged in" do
    	visit root_path
    	expect(page).to have_text('Logout')
    end

	end
end