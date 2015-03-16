require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  let(:member) { create(:member) }
  sign_in_user

  describe "GET #new" do
    it 'assigns @member' do
      get :new
      expect(assigns(:member)).to be_a_kind_of(Member)
    end

    it 'redirects to sign_in path' do
      sign_out @user
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'POST #create' do
    it 'creates member with valid attributes' do
      expect { post :create, member: attributes_for(:member) }.to change(Member, :count).by(1)
    end

    it 'redirect to show view' do
      post :create, member: attributes_for(:member)
      expect(response).to redirect_to(member_path(assigns(:member)))
    end

    context 'invalid attributes' do
      it 'does not creates member' do
        expect { post :create, member: { first_name: 'some', second_name: '' } }.not_to change(Member, :count)
      end

      it 'render new path' do
        post :create, member: { first_name: 'some', second_name: '' }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #edit' do
    before { get :edit, id: member}

    it 'assigns right member to @member' do
      expect(assigns(:member)).to eq(member)
    end

    it 'render edit view' do
      expect(response).to render_template(:edit)
    end

    it 'redirect to sign_in path' do
      sign_out @user
      get :edit, id: member
      expect(response).to redirect_to(new_user_session_path)
    end
  end
  
  describe 'PATCH #update' do
    it 'update member with valid attributes' do
      patch :update, id: member, member: attributes_for(:member, first_name: 'Newname')
      member.reload
      expect(member.first_name).to eq('Newname')
    end

    it 'assigns requested member to @member' do
      patch :update, id: member, member: attributes_for(:member, first_name: 'NewName')
      expect(assigns(:member)).to eq(member)
    end

    it 'does not update with invalid attributes' do
      patch :update, id: member, member: attributes_for(:member, first_name: '')
      member.reload
      expect(member.first_name).to eq('Mystring')
    end

    it 'redirect to show view' do
      patch :update, id: member, member: attributes_for(:member, first_name: 'NewName')
      expect(response).to redirect_to(member_path(member))
    end

    it 'redirect to sign_in path' do
      sign_out @user
      patch :update, id: member, member: attributes_for(:member, first_name: 'NewName')
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET #index' do
    # :woman_member is without partner
    let(:members) { create_list(:woman_member, 2) }
    before { get :index }

    it 'assigns members to @members' do
      expect(assigns(:members)).to match_array(members)
    end

    it 'render index view' do
      expect(response).to render_template(:index)
    end
  end

  describe 'DELETE #destroy' do
    before { member }

    it 'assigns to @member' do
      delete :destroy, id: member
      expect(assigns(:member)).to eq(member)
    end

    it 'redirect to sign in' do
      sign_out @user
      delete :destroy, id: member
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'destroy member' do
      expect { delete :destroy, id: member }.to change(Member, :count).by(-1)
    end
  end
end
