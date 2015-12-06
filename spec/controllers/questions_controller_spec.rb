require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  it "#show" do
    question = FactoryGirl.create(:question)
    get :show, id: question.id
    expect(assigns(:question)).to eq question
  end

  it "#index" do
    get :index
    expect(assigns(:questions)).to eq Question.latest || Question.greatest 
  end

  it "#new" do
    get :new
    expect(assigns(:question)).to be_a_new Question
  end

  context "#create" do
    let(:question_params) {FactoryGirl.attributes_for(:question)}
    let(:invalid_question_params) { {question: {title: "Hello"}}}
    it "creates a new question with valid params" do
      user = FactoryGirl.create(:user)
      stub_current_user user
      post :create, question: question_params
      expect(assigns(:question).id).to be_truthy
    end

    it "redirects to questions index if successful" do
      user = FactoryGirl.create(:user)
      stub_current_user user
      post :create, question: question_params
      expect(response).to redirect_to questions_path
    end

    it "renders new template if unsuccessful" do
      user = FactoryGirl.create(:user)
      stub_current_user user
      post :create, question: invalid_question_params
      expect(response).to render_template :'questions/new'
    end
  end

    it "#edit" do
      user = FactoryGirl.create(:user)
      stub_current_user user
      question = FactoryGirl.create(:question)
      get :edit, id: question.id
      expect(response).to render_template :'questions/edit'
    end

    context "#update" do
      let(:question_params) {{title: "Hello", body: "New body"}}
      let(:invalid_question_params)  {{title: ""}}

      it "should update a question with valid params and redirect to question's show page" do
        user = FactoryGirl.create(:user)
        stub_current_user user
        question = FactoryGirl.create(:question, user: user)
        old_attributes = question.attributes
        expect{
          put :update, id: question.id, question: question_params
          }.to change{question.reload.title}.from(old_attributes["title"]).to("Hello")
      end

      it "should not update a question with invalid params" do
        user = FactoryGirl.create(:user)
        stub_current_user user
        question = FactoryGirl.create(:question, user: user)
        put :update, id: question.id, question: invalid_question_params
        question.reload.title
            expect(question.title).not_to eq(invalid_question_params[:title])
      end
    end

    it "#destroy" do
      question = FactoryGirl.create(:question)
      get :destroy, id: question.id
      expect(assigns(:question)).to eq nil
    end
end
