require 'rails_helper'

RSpec.describe TagsController, type: :controller do

  describe 'tag index' do
    it "redirects to tags/index" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'tag show' do
    it "redirects to tags/show with tag" do
      tag = FactoryGirl.create(:tag)
      get :show, id: tag
      expect(response).to render_template :show
    end
  end

  describe 'tag search' do
    it "redirects to tags/show with tag" do
      tag = FactoryGirl.create(:tag)
      get :search, search_name: tag.name
      expect(response).to render_template :show
    end
  end

end