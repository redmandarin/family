require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  sign_in_user

  let(:article) { create(:article) }

  describe 'GET #index'

  describe 'GET #show' do
    before { get :show, id: article}

    it 'render show template' do
      expect(response).to render_template(:show)
    end

    it 'assigns article to @article' do
      expect(assigns(:article)).to eq(article)
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'redirect to sign_in_path path' do
      sign_out @user
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'render new path' do
      expect(response).to render_template(:new)
    end

    it 'assigns article to @article' do
      expect(assigns(:article)).to be_a_kind_of(Article)
    end
  end

  describe 'POST #create' do
    let(:member) { create(:member) }
    let(:another_member) { create(:member) }
    
    context 'valid attributes' do
      it 'creates new article' do
        expect { post :create, article: attributes_for(:article) }.to change(@user.articles, :count).by(1)
      end

      it 'creates with assotiated members' do
        post :create, article: { title: "title", body: "body", member_ids: [member.id, another_member.id] }
        expect(assigns(:article).member_ids).to match_array([member.id, another_member.id])
      end

      it 'redirects to article_path' do
        post :create, article: attributes_for(:article)
        expect(response).to redirect_to(assigns(:article))
      end
    end

    context 'invalid attributes' do
      it 'does not create article with invalid attributes' do
        expect { post :create, article: { title: '' } }.not_to change(@user.articles, :count)
      end

      it 'render template new' do
        post :create, article: { title: '' }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    before { get :edit, id: article }

    it 'render template' do
      expect(response).to render_template(:edit)
    end

    it 'assigns article to @article' do
      expect(assigns(:article)).to eq(article)
    end
  end

  describe 'PATCH #update' do 
    context 'valid attributes' do
      before { patch :update, id: article, article: { title: "new str" } }
      it 'update' do
        article.reload
        expect(article.title).to eq("new str")
      end

      it 'redirects to show path' do
        expect(response).to redirect_to(article_path(article))
      end

      it 'does not change count' do
        expect { patch :update, id: article, article: { title: "new str" } }.not_to change(Article, :count)
      end
    end

    it 'redirects to sign in' do
      sign_out @user
      patch :update, id: article, article: { title: "new str" }
      expect(response).to redirect_to(new_user_session_path)
    end

    context 'invalid attributes' do
      it 'does not update' do
        title = article.title
        patch :update, id: article, article: { title: "" }
        article.reload
        expect(article.title).to eq(title)
      end

      it 'render edit template' do
        patch :update, id: article, article: { title: "" }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to sign in' do
      sign_out @user
      delete :destroy, id: article
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'destroy article' do
      article
      expect { delete :destroy, id: article }.to change(Article, :count).by(-1)
    end
  end
end
