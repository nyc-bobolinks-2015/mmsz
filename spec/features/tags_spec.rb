require'rails_helper'

feature 'tags page' do 
  background do
    # add setup details
  end


  scenario 'go to tags index page from root_path' do 
    visit root_path
    click_link "Tags"
    expect(current_path).to eq tags_path
  end 

  # scenario 'go to tags show page from index_page' do 
  #   visit tags_path
  #   click_link('things')
  #   expect(current_path).to eq tag_path(1)
  # end 

  

end