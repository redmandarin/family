require 'rails_helper'

RSpec.describe ConnectionsController, type: :controller do
  let(:member) { create(:member) }
  let(:another_member) { create(:member) }
  let(:connection) { create(:connection, parent: member) }

  describe "GET #new" do
    sign_in_user
    before { get :new, member_id: member }

    it { expect(assigns(:connection)).to be_a(Connection) }
    it { expect(response).to render_template(:new) }
  end

  describe "GET #index" do
    let(:another_connection) { create(:connection, child: member) }

    it "assigns all user connections" do
      another_connection
      connection
      get :index, member_id: member
      expect(assigns(:connections)).to match_array([connection, another_connection])
    end
  end

  describe "POST #create" do
    sign_in_user

    it 'create new connection with child' do
      expect { post :create, member_id: member, connection: { child_id: another_member } }.to change(member.connections, :count).by(1)
    end

    it 'redirect to index view' do
      post :create, member_id: member, connection: { child_id: another_member }
      # puts response.to_a
      expect(response).to redirect_to(member_connections_path(member))
    end

    it 'create new connection with parent' do
      expect { post :create, member_id: member, connection: { parent_id: another_member } }.to change(member.reverse_connections, :count).by(1)
    end

    it 'does not create connection' do 
      sign_out @user
      expect { post :create, member_id: member, connection: { child_id: another_member } }.not_to change(member.connections, :count)
    end
  end

  describe "DELETE #destroy" do
    sign_in_user
    let!(:connection) { create(:connection, parent: member) }

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
