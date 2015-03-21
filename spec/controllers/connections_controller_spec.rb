require 'rails_helper'

RSpec.describe ConnectionsController, type: :controller do
  let(:member) { create(:member) }
  let(:another_member) { create(:member) }
  let(:connection) { create(:connection, procreator: member) }

  describe "GET #new" do
    sign_in_user
    before { get :new, member_id: member }

    it { expect(assigns(:connection)).to be_a(Connection) }
    it { expect(response).to render_template(:new) }
  end

  describe "GET #index" do
    let(:another_connection) { create(:connection, baby: member) }
    let(:children_list) { create_list(:connection, 2, procreator: member) }
    let(:parents_list) { create_list(:connection, 2, baby: member) }

    it 'assigns parents to @parents' do
      ar = []
      parents_list.each { |p| ar << p.procreator }
      get :index, member_id: member
      expect(assigns(:parents)).to match_array(ar)
    end

    it 'assigns children to @children' do
      ar = []
      children_list.each { |p| ar << p.baby }
      get :index, member_id: member
      expect(assigns(:children)).to match_array(ar)
    end
  end

  describe "POST #create" do
    sign_in_user

    describe 'after create' do 
      subject(:connection) { build(:connection) }

      it 'call update parent after create' do
        expect(connection).to receive(:set_parent_ancestry)
        subject.save!
      end

      it 'member update parent' do
        expect(connection.baby).to receive(:update_attributes).with(parent_id: connection.procreator_id)
        subject.save!
      end
    end
    
    it 'create new connection with baby' do
      expect { post :create, member_id: member, connection: { baby_id: another_member } }.to change(member.connections, :count).by(1)
    end

    it 'redirect to index view' do
      post :create, member_id: member, connection: { baby_id: another_member }
      expect(response).to redirect_to(member_connections_path(member))
    end

    it 'create new connection with parent' do
      expect { post :create, member_id: member, connection: { procreator_id: another_member } }.to change(member.reverse_connections, :count).by(1)
    end

    it 'does not create connection' do 
      sign_out @user
      expect { post :create, member_id: member, connection: { baby_id: another_member } }.not_to change(member.connections, :count)
    end
  end

  describe "DELETE #destroy" do
    sign_in_user
    let!(:connection) { create(:connection, procreator: member) }

    it 'redirect to member connections path' do
      member
      delete :destroy, id: connection, member_id: member
      expect(assigns(:connection)).to eq connection
    end

    it 'assigns connection to @connection' do
      delete :destroy, id: connection, member_id: member
      expect(assigns(:connection)).to eq connection
    end

    it 'destroy connection' do
      connection
      expect { delete :destroy, id: connection, member_id: member }.to change(member.connections, :count).by(-1)
    end
  end
end
