require 'rails_helper'

feature 'Tags index page' do

  before :each do
    user = FactoryGirl.create(:user)
      stub_current_user(user)
      5.times{FactoryGirl.create(:tag)}
  end

  scenario 'tags link links to tags/index page from root_path' do
    visit root_path
    click_link("Tags")
    expect(current_path).to eq tags_path
  end

  scenario 'tags link to thier show page from index_page' do
    visit tags_path
    click_link(Tag.last.name)
    expect(current_path).to eq tag_path(Tag.last)
  end

  scenario 'search by name form takes you to search route' do
    visit tags_path
    fill_in 'search_name', with: Tag.last.name
    click_button("Search By Tag")
    expect(current_path).to eq "/tags/search"
  end

end

feature 'Tags show page' do

  before :each do
    user = FactoryGirl.create(:user)
      stub_current_user user
      5.times{FactoryGirl.create(:tag)}
  end

  scenario 'tag is displayed under questions for that tag' do
    visit tag_path(Tag.first)
    expect(page).to have_content Tag.first.name
  end

  scenario 'vote count for questions are displayed' do
    visit tag_path(Tag.first)
    expect(page).to have_content Tag.first.questions.first.vote_count

  end

  scenario 'answer count for questions are displayed' do
    visit tag_path(Tag.first)
    expect(page).to have_content Tag.first.questions.first.answers.count
  end

end
