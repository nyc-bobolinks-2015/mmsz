require 'spec_helper'

feature 'User browsing the website' do
	before :each do
		user = FactoryGirl.create(:user)
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

    it "can go to a question-show page" do
    	question = FactoryGirl.create(:question)
    	visit root_path
    	click_link("#{question.title}", match: :first)
    	expect(current_path).to eq(question_path(question))
    end

    it "Can get the form to post a question" do
    	visit root_path
    	click_link("Ask a Question")
    	expect(current_path).to eq(new_question_path)
    end

    it "Can post a question" do
    	visit new_question_path
    	question = FactoryGirl.build(:question)
    	fill_in "question_title", with: question.title
		  fill_in "question_body", with: question.body
		  click_button "Create Question"
		  expect(current_path).to eq(questions_path)
    end

    it "Cannot post a question without a title" do
    	visit new_question_path
    	question = FactoryGirl.build(:question, title: nil)
    	fill_in "question_title", with: question.title
		  fill_in "question_body", with: question.body
		  click_button "Create Question"
		  expect(page).to have_text("can't be blank")
    end

    # Factory for tags still not implimented so can't work.
    # it "Can click on a tag" do
    # 	question = FactoryGirl.create(:question)
    # 	visit root_path
    # 	click_link("#{question.tags.first.name}")
    # 	expect(current_path).to eq(tag_path(question.tags.first))
    # end

    it "Can go to Tag index page" do
    	visit root_path
    	click_link("Tags")

    	expect(current_path).to eq(tags_path)
    end

    it "Can create an Answer" do
    	question = FactoryGirl.create(:question)
    	visit question_path(question)
    	click_link("Add an answer")
    	answer = FactoryGirl.create(:answer)
    	fill_in "answer_body", with: answer.body
    	click_button "Create Answer"
    	expect(current_path).to eq(question_path(question))
    end

    it "Can create a Comment" do
    	question = FactoryGirl.create(:question)
    	visit question_path(question)
    	click_link("add a comment")
    	comment = FactoryGirl.create(:question_comment)
    	fill_in "comment_body", with: comment.body
    	click_button "Create Comment"
    	expect(current_path).to eq(question_path(question))
    end
	end
end