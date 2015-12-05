require 'spec_helper'

feature 'User browsing the website' do
	before :each do
		user = FactoryGirl.create(:user)
		# visit login_path
		# fill_in "password", with: user.password
		# fill_in "email", with: user.email
		# click_button "Log in"
		stub_current_user(user)
	end

	context "on hompage" do
		it "sees a list of recent question titles" do
			5.times{FactoryGirl.create(:question)}
      visit root_path
      expect(page).to have_css('li')
    end

    it "sees a Logout button when logged in" do
    	visit root_path
    	expect(page).to have_text('Logout')
    end

    it "sees its name on the page" do
    	user = FactoryGirl.create(:user)
    	stub_current_user(user)
    	visit root_path
    	expect(page).to have_text("#{user.username}")
    end

    it "goes to its profile page from the posts index" do
    	user = FactoryGirl.create(:user)
    	stub_current_user(user)
    	visit root_path
    	click_link("#{user.username}")
    	expect(current_path).to eq(user_path(user))
    end

    it "goes to another user's profile page from posts index" do
    	question = FactoryGirl.create(:question)
    	other_user = User.find_by(id: question.user_id)
    	visit root_path
    	click_link("#{other_user.username}")
    	expect(current_path).to eq(user_path(other_user))
    end

    it "can log out" do
    	visit	root_path

    	click_link("Logout")
    	expect(current_path).to eq(root_path)
    end

    it "can go to a post-show page" do
    	question = FactoryGirl.create(:question)
    	visit root_path
    	click_link("#{question.title}", match: :first)
    	expect(current_path).to eq(question_path(question))
    end
	end
end