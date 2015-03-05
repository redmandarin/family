require 'rails_helper'

RSpec.describe MembersController, type: :controller do

  describe "GET #new" do
    it 'assigns @member' do
      get :new
      expect(assigns(:member)).to be_a_kind_of(Member)
    end
  end

  describe 'POST #create' do
    it 'creates member with valid attributes' do
      expect { post :create, member: attributes_for(:member) }.to change(Member, :count).by(1)
    end

    it 'not creates member with invalid attributes' do
      expect { post :create, member: { first_name: 'some', second_name: '' } }.not_to change(Member, :count)
    end

    it 'redirect to show view' do
      post :create, member: attributes_for(:member)
      expect(response).to redirect_to(member_path(assigns(:member)))
    end
  end

  describe 'GET #edit' do
    let!(:member) { create(:member) }
    before { get :edit, id: member}

    it 'assigns right member to @member' do
      expect(assigns(:member)).to eq(member)
    end

    it 'render edit view' do
      expect(response).to render_template(:edit)
    end
  end
  
  describe 'PATCH #update' do
    it 'update member with valid attributes' do

    end
    it 'does not update with invalid attributes'
    it 'redirect to show view'
  end
  describe 'GET #index'

end
