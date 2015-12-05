require 'spec_helper'

feature 'User browsing the website' do
	before :each do
		stub_authorize_user!
		5.times{FactoryGirl.create(:question)}
	end

	context "on hompage" do
		it "sees a list of recent question titles" do
      visit root_path
      expect(page).to have_css('li')
    end
	end
end