require 'rails_helper'
RSpec.describe SubmissionsController, type: :controller do

  let(:author) { create(:user) }
  let!(:submission) { create(:submission, author: author) }
  describe 'GET index' do
    context 'with an authenticated sesssion' do
      before { authenticate_as(author) }

      it 'renders the index template' do
        get :index
        expect(response).to render_template('index')
      end

      it 'assigns the submissions' do
        get :index
        expect(assigns(:submissions)).to include(submission)
      end
    end

    context 'without an authenticated session' do
      it 'returns 403 forbidden' do
        get :index
        expect(response).to be_forbidden
      end
    end
  end

  describe 'GET edit' do
    context 'with an authenticated sesssion' do
      before { authenticate_as(author) }

      it 'renders the edit template' do
        get :edit, id: submission.id
        expect(response).to render_template('edit')
      end

      it 'assigns the submission' do
        get :edit, id: submission.id
        expect(assigns(:submission)).to eql(submission)
      end
    end

    context 'without an authenticated session' do
      it 'returns 403 forbidden' do
        get :edit, id: submission.id
        expect(response).to be_forbidden
      end
    end
  end

  describe 'PUT update' do
    context 'with an authenticated session' do
      before { authenticate_as(author) }

      it 'redirects to the submissions list' do
        put :update, id: submission.id, submission: valid_attributes
        expect(response).to redirect_to(submissions_path)
      end
    end

    context 'without an authenticated session' do
      it 'returns 403 forbidden' do
        put :update, id: submission.id
        expect(response).to be_forbidden
      end
    end
  end

  def valid_attributes
    {
      rating: 'good',
      achievements: 'some stuff',
      improvements: 'other stuff'
    }
  end
end
