require 'rails_helper'
RSpec.describe ReviewsController, type: :controller do
  let(:me) { create(:user) }

  describe 'GET new' do
    before do
      authenticate_as me
      get :index
    end

    it 'assigns a new review' do
      expect(assigns(:review)).to be_a(Review)
    end

    it 'assigns existing reviews' do
      expect(assigns(:reviews)).not_to be_nil
    end
  end

  describe 'POST create' do
    before do
      authenticate_as me
      get :index
    end

    describe 'with valid params and implicit subject' do
      it 'creates a new Review' do
        expect {
          post :create, review: valid_attributes
        }.to change(Review, :count).by(1)
      end

      it 'redirects back to the index' do
        post :create, review: valid_attributes
        expect(response).to redirect_to(reviews_path)
      end

      it 'assigns the review to me' do
        post :create, review: valid_attributes
        expect(Review.last.subject).to eql(me)
      end
    end

    describe 'with valid params and explicit subject' do
      let(:managee) { create(:user, manager: me) }

      it 'creates a new Review' do
        expect {
          post :create, user_id: managee.to_param, review: valid_attributes
        }.to change(Review, :count).by(1)
      end

      it 'redirects back to the index' do
        post :create, user_id: managee.to_param, review: valid_attributes
        expect(response).to redirect_to(reviews_path)
      end

      it 'assigns the review to the managee' do
        post :create, user_id: managee.to_param, review: valid_attributes
        expect(Review.last.subject).to eql(managee)
      end

      it 'checks that the subject is a managee of the current user' do
        third_party = create(:user)
        expect {
          post :create, user_id: third_party.to_param, review: valid_attributes
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe 'with invalid params' do
      before do
        post :create, review: { author_email: '' }
      end

      it 'assigns a newly created but unsaved review as @review' do
        expect(assigns(:review)).to be_a_new(Review)
      end

      it 're-renders the index template' do
        expect(response).to render_template('index')
      end
    end
  end

  def valid_attributes
    {
      relationship: 'Colleague',
      author_email: 'danny@example.com',
      author_name: 'Danny Boy'
    }
  end
end