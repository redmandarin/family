require 'rails_helper'

RSpec.describe Connection, type: :model do

  it { should belong_to :parent }
  it { should belong_to :child}

  it { should validate_presence_of :parent_id }
  it { should validate_presence_of :child_id }

  let(:member) { create(:member, first_name: 'Петр', last_name: "Гуськов", middle_name: "аркадьевич") }
  let(:another_member) { create(:member, first_name: 'Аркадий1', last_name: "Гуськов", middle_name: "аркадьевич") }

  describe '.all_connections' do
    let(:parent_member) { create(:member, first_name: 'Аркадий2', last_name: "Гуськов", middle_name: "аркадьевич") }
    let(:connection) { create(:connection, parent: member, child: another_member) }
    let(:parent_connection) { create(:connection, parent: parent_member, child: member) }

    it 'gives all connections' do
      expect(Connection.all_connections(member)).to match_array([connection, parent_connection])
    end
  end
end
